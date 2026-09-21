import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt_app/core/services/cloudinary_services.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateDoctorRepository {
  final FirebaseFirestore _firestore;
  final CloudinaryServices _cloudinaryService;
  final FirebaseAuth _firebaseAuth;

  CreateDoctorRepository({
    required this._firestore,
    required this._cloudinaryService, 
    required this._firebaseAuth,
  });

  Future<void> createDoctor({
    required String name,
    required String specialty,
    File? imageFile,
    bool? isActive,
  }) async {
    String? imageUrl;
    if (imageFile != null) {
      imageUrl = await _cloudinaryService.uploadImage(imageFile);
    }

    final docRef = _firestore.collection('doctors').doc();

    final doctor = DoctorModel(
      id: docRef.id,
      name: name,
      specialty: specialty,
      profileImageUrl: imageUrl ?? "",
      isActive: isActive ?? true,
      createdBy: _firebaseAuth.currentUser?.uid ??""
    );

    await docRef.set(doctor.toMap());
  }
}
