
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';
import 'package:doctor_hunt_app/features/patient/home/data/model/patient_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  HomeRepository({
    required this._firebaseAuth,
    required this._firestore,
    
  });

  Future<PatientModel?> getUserProfileData() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;
    try {
      final docSnapshot = await _firestore
          .collection("users")
          .doc(user.uid)
          .get();
      if (docSnapshot.exists && docSnapshot.data() != null) {
        final data = docSnapshot.data();
        return PatientModel(
          name: data?['name'],
          profileImage: data?['profileImage'],
        );
      }
      return PatientModel(name: user.displayName ?? "user", profileImage: null);
    } catch (e) {
      rethrow;
    }
  }

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
