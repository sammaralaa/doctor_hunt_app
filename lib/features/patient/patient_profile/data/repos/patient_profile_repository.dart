import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:doctor_hunt_app/core/models/patient_model.dart';
import 'package:doctor_hunt_app/core/services/cloudinary_services.dart';

class PatientProfileRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;
  final CloudinaryServices cloudinaryService;

  const PatientProfileRepository({
    required this.firestore,
    required this.firebaseAuth,
    required this.cloudinaryService,
  });

  Future<PatientModel> fetchPatientProfile() async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw Exception('User is not authenticated');
    }

    final doc = await firestore.collection('users').doc(user.uid).get();

    if (doc.exists && doc.data() != null) {
      final data = doc.data()!;
      return PatientModel.fromMap(data, user.uid);
    }

    return PatientModel(
      uid: user.uid,
      name: user.displayName?.isNotEmpty == true
          ? user.displayName!
          : 'Patient User',
      email: user.email?.isNotEmpty == true
          ? user.email!
          : 'patient@doctorhunt.com',
      role: 'patient',
      profileImage: user.photoURL,
    );
  }

  Future<PatientModel> updatePatientProfile({
    required String name,
    required String phoneNumber,
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
      'phoneNumber': phoneNumber,
      'role': 'patient',
      'profileImage': ?imageUrl,
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
      // In case Firebase user token update has restrictions
    }

    return PatientModel(
      uid: user.uid,
      name: name,
      email: user.email ?? 'patient@doctorhunt.com',
      phoneNumber: phoneNumber,
      role: 'patient',
      profileImage: imageUrl ?? existingImageUrl,
    );
  }
}
