import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt_app/core/services/cloudinary_services.dart';
import 'package:doctor_hunt_app/core/utils/doctor_specialty_enum.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';
import 'package:image_picker/image_picker.dart';

class EditDoctorRepository {
  final FirebaseFirestore _firebaseFirestore;
  final CloudinaryServices _cloudinaryService;

  EditDoctorRepository({
    required this._firebaseFirestore,
    required this._cloudinaryService,
  });

  Future<DoctorModel> getDoctorById(String doctorId) async {
    final docSnapshot = await _firebaseFirestore
        .collection('doctors')
        .doc(doctorId)
        .get();

    if (!docSnapshot.exists || docSnapshot.data() == null) {
      throw Exception('Doctor not found');
    }

    return DoctorModel.fromMap(docSnapshot.data()!, docSnapshot.id);
  }

  Future<void> updateDoctor({
    required String doctorId,
    required String name,
    required DoctorSpecialty specialty,
    required bool isActive,
    String? newImagePath,
  }) async {
    String? uploadedImageUrl;

  // 1. Upload new image if local path is provided
  if (newImagePath != null && newImagePath.isNotEmpty) {
    uploadedImageUrl = await _cloudinaryService.uploadImage(File(newImagePath));
  }
    final Map<String, dynamic> updateData = {
      'name': name,
      'specialty': specialty.key,
      'updatedAt': FieldValue.serverTimestamp(),
      'isActive': isActive,
    };

    if (newImagePath != null && newImagePath.isNotEmpty) {
      updateData['profileImageUrl'] = uploadedImageUrl;
    }

    await _firebaseFirestore
        .collection('doctors')
        .doc(doctorId)
        .update(updateData);
  }
  
}
