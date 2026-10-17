import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt_app/core/models/appointment_model.dart';

class AppointmentDetailsRepository {
  final FirebaseFirestore firestore;

  AppointmentDetailsRepository({required this.firestore});

  Future<AppointmentModel> getAppointmentById(String appointmentId) async {
    final doc =
        await firestore.collection('appointments').doc(appointmentId).get();

    if (!doc.exists || doc.data() == null) {
      throw Exception('Appointment not found');
    }

    final appointment = AppointmentModel.fromJson(doc.data()!, doc.id);

    // If patient email is not populated on the appointment, attempt to fetch from user profile
    String? email = appointment.patientEmail;
    if (email == null || email.isEmpty) {
      if (appointment.patientId.isNotEmpty) {
        try {
          final userDoc = await firestore
              .collection('users')
              .doc(appointment.patientId)
              .get();
          if (userDoc.exists && userDoc.data() != null) {
            email = userDoc.data()?['email'] as String?;
          }
        } catch (_) {}
      }
    }

    if (email == null || email.isEmpty) {
      final sanitizedName = appointment.patientName
          .toLowerCase()
          .replaceAll(RegExp(r'\s+'), '.');
      email = '$sanitizedName@example.com';
    }

    return appointment.copyWith(patientEmail: email);
  }

  Future<void> cancelAppointment({required String appointmentId}) async {
    await firestore.collection('appointments').doc(appointmentId).update({
      'status': 'Cancelled',
    });
  }

  Future<void> markAppointmentCompleted({required String appointmentId}) async {
    await firestore.collection('appointments').doc(appointmentId).update({
      'status': 'Completed',
    });
  }
}
