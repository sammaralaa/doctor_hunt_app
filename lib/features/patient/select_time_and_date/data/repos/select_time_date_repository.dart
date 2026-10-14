import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt_app/core/models/appointment_model.dart';
import 'package:doctor_hunt_app/core/utils/doctor_specialty_enum.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';
import 'package:doctor_hunt_app/features/patient/select_time_and_date/data/date_slot_model.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class SelectTimeDateRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  SelectTimeDateRepository({
    required this.firestore,
    required this.firebaseAuth,
  });

  Future<DoctorModel> getDoctorById(String doctorId) async {
    final docSnapshot =
        await firestore.collection('doctors').doc(doctorId).get();

    if (!docSnapshot.exists || docSnapshot.data() == null) {
      throw Exception(t.doctorNotFound);
    }

    return DoctorModel.fromMap(docSnapshot.data()!, docSnapshot.id);
  }

  Future<List<AppointmentModel>> getBookedAppointmentsForDate({
    required String doctorId,
    required DateTime date,
  }) async {
    final possibleDateFormats = [
      DateFormat('yyyy-MM-dd').format(date),
      DateFormat('d MMM yyyy').format(date),
      DateFormat('dd MMM yyyy').format(date),
      DateFormat('yyyy/MM/dd').format(date),
      DateFormat('d/M/yyyy').format(date),
    ];

    try {
      final querySnapshot = await firestore
          .collection('appointments')
          .where('doctorId', isEqualTo: doctorId)
          .where('date', whereIn: possibleDateFormats)
          .get();

      return querySnapshot.docs
          .map((doc) => AppointmentModel.fromJson(doc.data(), doc.id))
          .where((app) => app.status.toLowerCase() != 'cancelled')
          .toList();
    } catch (_) {
      final fallbackSnapshot = await firestore
          .collection('appointments')
          .where('doctorId', isEqualTo: doctorId)
          .get();

      return fallbackSnapshot.docs
          .map((doc) => AppointmentModel.fromJson(doc.data(), doc.id))
          .where((app) {
            if (app.status.toLowerCase() == 'cancelled') return false;
            return possibleDateFormats.contains(app.date.trim());
          })
          .toList();
    }
  }

  Future<AppointmentModel> bookAppointment({
    required DoctorModel doctor,
    required DateTime selectedDate,
    required TimeSlotModel selectedTimeSlot,
  }) async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw Exception('User is not authenticated');
    }

    final userDoc = await firestore.collection('users').doc(user.uid).get();
    final userData = userDoc.data();
    final patientName = (userData?['name'] as String?)?.trim().isNotEmpty == true
        ? (userData!['name'] as String).trim()
        : 'Patient';
    final patientImage = userData?['profileImage'] as String?;

    final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    final formattedTime = selectedTimeSlot.formattedTime;
    final specialty = DoctorSpecialty.fromKey(doctor.specialty).displayName;

    final appointment = AppointmentModel(
      id: '',
      doctorId: doctor.id ?? '',
      doctorName: doctor.name,
      doctorSpecialty: specialty,
      doctorImage: doctor.profileImageUrl,
      patientId: user.uid,
      patientName: patientName,
      patientImage: patientImage,
      date: formattedDate,
      time: formattedTime,
      fee: doctor.consultationFee,
      status: 'Upcoming',
    );

    final docRef = await firestore
        .collection('appointments')
        .add(appointment.toJson());

    return AppointmentModel(
      id: docRef.id,
      doctorId: appointment.doctorId,
      doctorName: appointment.doctorName,
      doctorSpecialty: appointment.doctorSpecialty,
      doctorImage: appointment.doctorImage,
      patientId: appointment.patientId,
      patientName: appointment.patientName,
      patientImage: appointment.patientImage,
      date: appointment.date,
      time: appointment.time,
      fee: appointment.fee,
      status: appointment.status,
    );
  }
}
