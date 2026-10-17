import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt_app/core/models/patient_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PatientSettingsRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  const PatientSettingsRepository({
    required this.firestore,
    required this.firebaseAuth,
  });

  Future<PatientModel> fetchPatientProfile() async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw Exception('User is not authenticated');
    }

    final doc = await firestore.collection('users').doc(user.uid).get();

    if (doc.exists && doc.data() != null) {
      final data = doc.data()!;
      return PatientModel.fromMap(data, user.uid);
    }

    return PatientModel(
      uid: user.uid,
      name: user.displayName?.isNotEmpty == true
          ? user.displayName!
          : 'Patient User',
      email: user.email?.isNotEmpty == true
          ? user.email!
          : 'patient@doctorhunt.com',
      role: 'patient',
      profileImage: user.photoURL,
    );
  }
}
