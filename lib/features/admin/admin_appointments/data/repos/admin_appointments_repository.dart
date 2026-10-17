import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt_app/core/models/appointment_model.dart';

class AdminAppointmentsRepository {
  final FirebaseFirestore firestore;

  const AdminAppointmentsRepository({
    required this.firestore,
  });

  /// Fetches all appointments across the system with a "Lazy Update" mechanism.
  ///
  /// For each appointment, if its scheduled date and time has passed and its current
  /// status is 'upcoming' or 'pending':
  /// a. Updates its status to 'Completed' directly in Firestore asynchronously.
  /// b. Modifies the local [AppointmentModel] instance to 'Completed' before yielding it.
  Stream<List<AppointmentModel>> getAppointments() {
    return firestore
        .collection('appointments')
        .snapshots()
        .map(_processLazyStatusUpdate);
  }

  /// Backward-compatible alias for [getAppointments].
  Stream<List<AppointmentModel>> fetchAllAppointments() => getAppointments();

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
        _updateStatusInFirestoreAsync(appointment.id, 'Completed');
        return appointment.copyWith(status: 'Completed');
      }

      return appointment;
    }).toList();
  }

  void _updateStatusInFirestoreAsync(String appointmentId, String status) {
    if (appointmentId.isEmpty) return;

    firestore.collection('appointments').doc(appointmentId).update({
      'status': status,
    }).catchError((_) {});
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
