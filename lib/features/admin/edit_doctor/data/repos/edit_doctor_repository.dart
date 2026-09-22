import 'package:cloud_firestore/cloud_firestore.dart';
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
}