import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt_app/core/utils/doctor_specialty_enum.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';

class EditDoctorRepository {
  final FirebaseFirestore _firebaseFirestore;

  EditDoctorRepository({required this._firebaseFirestore});

  Future<DoctorModel> getDoctorById(String doctorId) async {
    final docSnapshot = await _firebaseFirestore
        .collection('doctors')
        .doc(doctorId)
        .get();

    if (!docSnapshot.exists || docSnapshot.data() == null) {
      throw Exception('Doctor not found');
    }

    return DoctorModel.fromMap(
      docSnapshot.data()!,
      docSnapshot.id,
    );
  }
  Future<void> updateDoctor({
    required String doctorId,
    required String name,
    required DoctorSpecialty specialty,
    required bool isActive,
    String? imageUrl, 
      }) async {
   
    final Map<String, dynamic> updateData = {
      'name': name,
      'specialty': specialty.key, 
      'updatedAt': FieldValue.serverTimestamp(),
      'isActice':isActive
    };

    if (imageUrl != null && imageUrl.isNotEmpty) {
      updateData['profileImageUrl'] = imageUrl;
    }

    await _firebaseFirestore
        .collection('doctors')
        .doc(doctorId)
        .update(updateData);
  }
}