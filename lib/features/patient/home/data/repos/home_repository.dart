import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt_app/core/services/cloudinary_services.dart';
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

   Future<File?> pickProfileImage({ImageSource source = ImageSource.gallery}) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 80,
    );

    if (pickedFile == null) return null;
    return File(pickedFile.path);
  }
  Future<String?> uploadOrUpdateProfileImage({required File imageFile}) async {
    final String? uid = _firebaseAuth.currentUser?.uid;

    if (uid == null) {
      throw Exception("User not logged in");
    }

    final String? imageUrl = await _cloudinaryService.uploadImage(imageFile);

    if (imageUrl != null) {
      await _firestore.collection('users').doc(uid).set({
        'profileImage': imageUrl,
      }, SetOptions(merge: true));
    }

    return imageUrl;
  }
}
