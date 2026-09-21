import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt_app/core/services/cloudinary_services.dart';
import 'package:doctor_hunt_app/features/patient/home/data/model/patient_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class HomeRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final CloudinaryServices _cloudinaryService;
   final ImagePicker _picker = ImagePicker();

  HomeRepository({
    required this._firebaseAuth,
    required this._firestore,
    required this._cloudinaryService,
  });

  Future<PatientModel?> getUserProfileData() async {
    final user = _firebaseAuth.currentUser;
    //final PatientModel userData = PatientModel(name: )

    if (user == null) return null;
    try {
      final docSnapshot = await _firestore
          .collection("users")
          .doc(user.uid)
          .get();
      if (docSnapshot.exists && docSnapshot.data() != null) {
        final data = docSnapshot.data();
        return PatientModel(
          name: data?['name'] ?? user.displayName,
          profileImage: data?['profileImage'],
        );
      }
      return PatientModel(name: user.displayName ?? "user", profileImage: null);
    } catch (e) {
      rethrow;
    }
  }

  //  Future<File?> pickProfileImage({
  //   ImageSource source = ImageSource.gallery,
  // }) async {
  //   final XFile? pickedFile = await _picker.pickImage(
  //     source: source,
  //     maxWidth: 512,
  //     maxHeight: 512,
  //     imageQuality: 80,
  //   );

  //   if (pickedFile == null) return null;
  //   return File(pickedFile.path);
  // }

  Future<PatientModel?> uploadOrUpdateProfileImage({
    required File imageFile,
  }) async {
    final String? uid = _firebaseAuth.currentUser?.uid;

    final String? imageUrl = await _cloudinaryService.uploadImage(imageFile);

    if (imageUrl != null) {
      await _firestore.collection('users').doc(uid).set({
        'profileImage': imageUrl,
      }, SetOptions(merge: true));
    }

    return PatientModel(
      name: _firebaseAuth.currentUser?.displayName ?? "User",
      profileImage: imageUrl,
    );
  }
}
