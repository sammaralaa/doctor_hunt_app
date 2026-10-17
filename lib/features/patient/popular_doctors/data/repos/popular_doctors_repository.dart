import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';

class PopularDoctorsRepository {
  final FirebaseFirestore firestore;

  PopularDoctorsRepository({required this.firestore});

  Future<List<DoctorModel>> getPopularDoctors() async {
    final snapshot = await firestore.collection('doctors').get();
    return snapshot.docs
        .map((doc) => DoctorModel.fromMap(doc.data(), doc.id))
        .toList();
  }
}
