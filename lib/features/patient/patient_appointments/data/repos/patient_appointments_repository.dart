import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt_app/core/models/appointment_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PatientAppointmentsRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  PatientAppointmentsRepository({
    required this.firestore,
    required this.firebaseAuth,
  });

  Stream<List<AppointmentModel>> fetchMyAppointments() {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      return Stream.error(Exception('User is not authenticated'));
    }

    return firestore
        .collection('appointments')
        .where('patientId', isEqualTo: user.uid)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => AppointmentModel.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }

  Future<void> cancelAppointment({required String appointmentId}) async {
    await firestore.collection('appointments').doc(appointmentId).update({
      'status': 'Cancelled',
    });
  }
}
