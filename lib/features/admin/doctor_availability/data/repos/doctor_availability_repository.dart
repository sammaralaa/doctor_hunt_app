import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';
import 'package:doctor_hunt_app/features/admin/doctor_availability/data/model/doctor_availability_model.dart';

class DoctorAvailabilityRepository {
  final FirebaseFirestore firestore;

  DoctorAvailabilityRepository({required this.firestore});

  Future<DoctorModel> getDoctorById(String doctorId) async {
    final docSnapshot =
        await firestore.collection('doctors').doc(doctorId).get();

    if (!docSnapshot.exists || docSnapshot.data() == null) {
      throw Exception('Doctor not found');
    }

    return DoctorModel.fromMap(docSnapshot.data()!, docSnapshot.id);
  }

  Future<void> saveDoctorAvailability({
    required String doctorId,
    required DoctorAvailabilityModel availability,
  }) async {
    await firestore.collection('doctors').doc(doctorId).update({
      'availability': availability.toMap(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
