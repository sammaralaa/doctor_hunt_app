import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';

class AdminDocDetailsRepository {
  final FirebaseFirestore _firestore;

  AdminDocDetailsRepository({
    required this._firestore,
  }) ;
    Future<DoctorModel> getDoctorById(String doctorId) async {
    final docSnapshot = await _firestore
        .collection('doctors')
        .doc(doctorId)
        .get();

    if (!docSnapshot.exists || docSnapshot.data() == null) {
      throw Exception('Doctor not found');
    }

    return DoctorModel.fromMap(docSnapshot.data()!, docSnapshot.id);
  }
   Future<void> updateDoctorStatus({
    required String doctorId,
    required bool isActive,
  }) async {
    try {
      await _firestore.collection('doctors').doc(doctorId).update({
        'isActive': isActive,
        
      });
    } catch (e) {
      throw Exception('Failed to update doctor status ${e.toString()}');
    }
  }
  Future<void> deleteDoctor(String doctorId) async {
    try {
      await _firestore.collection('doctors').doc(doctorId).delete();
    } catch (e) {
      throw Exception('Failed to Delete Doctor  ${e.toString()}');
    }
  }
}