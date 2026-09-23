import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';

class DoctorsListRepository {
  final FirebaseFirestore _firestore;

  DoctorsListRepository({required this._firestore});
  Stream<List<DoctorModel>> getDoctors() {
  return _firestore
      .collection('doctors')
      .snapshots() 
      .map((snapshot) {
    return snapshot.docs.map((doc) {
      return DoctorModel.fromMap(doc.data(), doc.id);
    }).toList();
  });
}
}
