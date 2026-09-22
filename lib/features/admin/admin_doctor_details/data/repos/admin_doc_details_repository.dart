import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt_app/core/services/cloudinary_services.dart';

class AdminDocDetailsRepository {
  final FirebaseFirestore _firestore;
  final CloudinaryServices _cloudinaryService;

  AdminDocDetailsRepository({
    required this._firestore,
    required this._cloudinaryService,
  }) ;

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