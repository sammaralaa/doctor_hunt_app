import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt_app/core/models/appointment_model.dart';

class AdminAppointmentsRepository {
  final FirebaseFirestore firestore;

  const AdminAppointmentsRepository({
    required this.firestore,
  });

  Stream<List<AppointmentModel>> fetchAllAppointments() {
    return firestore
        .collection('appointments')
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

  Future<void> markAsCompleted({required String appointmentId}) async {
    await firestore.collection('appointments').doc(appointmentId).update({
      'status': 'Completed',
    });
  }
}
