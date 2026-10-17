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

  /// Fetches appointments for the currently authenticated patient with a "Lazy Update" mechanism.
  ///
  /// For each appointment, if its scheduled date and time has passed and its current
  /// status is 'upcoming' or 'pending':
  /// a. Updates its status to 'Completed' directly in Firestore asynchronously.
  /// b. Modifies the local [AppointmentModel] instance to 'Completed' before yielding it.
  Stream<List<AppointmentModel>> getAppointments() {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      return Stream.error(Exception('User is not authenticated'));
    }

    return firestore
        .collection('appointments')
        .where('patientId', isEqualTo: user.uid)
        .snapshots()
        .map(_processLazyStatusUpdate);
  }

  /// Backward-compatible alias for [getAppointments].
  Stream<List<AppointmentModel>> fetchMyAppointments() => getAppointments();

  List<AppointmentModel> _processLazyStatusUpdate(
    QuerySnapshot<Map<String, dynamic>> snapshot,
  ) {
    final now = DateTime.now();

    return snapshot.docs.map((doc) {
      final appointment = AppointmentModel.fromJson(doc.data(), doc.id);

      final scheduledDateTime = appointment.parseScheduledDateTime();
      final statusLower = appointment.status.trim().toLowerCase();
      final isUpcomingOrPending =
          statusLower == 'upcoming' || statusLower == 'pending';
      final hasPassed =
          scheduledDateTime != null && scheduledDateTime.isBefore(now);

      if (hasPassed && isUpcomingOrPending) {
        // a. Update status to 'Completed' directly in Firestore asynchronously
        _updateStatusInFirestoreAsync(appointment.id, 'Completed');

        // b. Modify the local AppointmentModel instance before returning/yielding it
        return appointment.copyWith(status: 'Completed');
      }

      return appointment;
    }).toList();
  }

  void _updateStatusInFirestoreAsync(String appointmentId, String status) {
    if (appointmentId.isEmpty) return;

    firestore.collection('appointments').doc(appointmentId).update({
      'status': status,
    }).catchError((_) {
      // Background fire-and-forget sync error handling
    });
  }

  Future<void> cancelAppointment({required String appointmentId}) async {
    await firestore.collection('appointments').doc(appointmentId).update({
      'status': 'Cancelled',
    });
  }
}
