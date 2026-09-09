import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt_app/core/services/cloudinary_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeRepository {
   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CloudinaryServices _cloudinaryService = CloudinaryServices();

Future<String?> uploadOrUpdateProfileImage({
    required File imageFile,
  }) async {
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