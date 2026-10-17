import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:doctor_hunt_app/core/services/cloudinary_services.dart';
import 'package:doctor_hunt_app/features/admin/edit_admin_profile/data/model/admin_profile_model.dart';

class EditAdminProfileRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;
  final CloudinaryServices cloudinaryService;

  const EditAdminProfileRepository({
    required this.firestore,
    required this.firebaseAuth,
    required this.cloudinaryService,
  });

  Future<AdminProfileModel> fetchAdminProfile() async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw Exception('User is not authenticated');
    }

    final doc = await firestore.collection('users').doc(user.uid).get();

    if (doc.exists && doc.data() != null) {
      final data = doc.data()!;
      return AdminProfileModel(
        uid: user.uid,
        name: (data['name'] as String?)?.isNotEmpty == true
            ? data['name'] as String
            : (user.displayName?.isNotEmpty == true
                  ? user.displayName!
                  : 'Ahmed Khaled'),
        email: (data['email'] as String?)?.isNotEmpty == true
            ? data['email'] as String
            : (user.email?.isNotEmpty == true
                  ? user.email!
                  : 'admin@doctorhunt.com'),
        clinicLocation: (data['clinicLocation'] as String?)?.isNotEmpty == true
            ? data['clinicLocation'] as String
            : 'DoctorHunt HQ Clinic',
        profileImage:
            (data['profileImage'] as String?) ?? (user.photoURL ?? ''),
      );
    }

    return AdminProfileModel(
      uid: user.uid,
      name: user.displayName?.isNotEmpty == true
          ? user.displayName!
          : 'Ahmed Khaled',
      email: user.email?.isNotEmpty == true
          ? user.email!
          : 'admin@doctorhunt.com',
      clinicLocation: 'DoctorHunt HQ Clinic',
      profileImage: user.photoURL ?? '',
    );
  }

  Future<AdminProfileModel> updateAdminProfile({
    required String name,
    required String clinicLocation,
    File? imageFile,
    String? existingImageUrl,
  }) async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw Exception('User is not authenticated');
    }

    String? imageUrl = existingImageUrl;
    if (imageFile != null) {
      imageUrl = await cloudinaryService.uploadImage(imageFile);
    }

    final updates = <String, dynamic>{
      'name': name,
      'email': user.email ?? 'admin@doctorhunt.com',
      'clinicLocation': clinicLocation,
      'role': 'admin',
      'profileImage': imageUrl,
    };

    await firestore
        .collection('users')
        .doc(user.uid)
        .set(updates, SetOptions(merge: true));

    try {
      await user.updateDisplayName(name);
      if (imageUrl != null && imageUrl.isNotEmpty) {
        await user.updatePhotoURL(imageUrl);
      }
    } catch (_) {
      // In case token update has restrictions
    }

    return AdminProfileModel(
      uid: user.uid,
      name: name,
      email: user.email ?? 'admin@doctorhunt.com',
      clinicLocation: clinicLocation,
      profileImage: imageUrl ?? '',
    );
  }
}
