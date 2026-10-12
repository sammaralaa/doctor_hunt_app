import 'package:equatable/equatable.dart';

enum AppointmentFilter { upcoming, completed, cancelled }

class MockAppointment {
  final String id;
  final String patientName;
  final String patientImage;
  final String doctorName;
  final String doctorSpecialty;
  final String date;
  final String time;
  final String fee;
  final AppointmentFilter status;
  final double? rating;
  final String? reviewText;

  MockAppointment({
    required this.id,
    required this.patientName,
    required this.patientImage,
    required this.doctorName,
    required this.doctorSpecialty,
    required this.date,
    required this.time,
    required this.fee,
    required this.status,
    this.rating,
    this.reviewText,
  });
}

class AdminAppointmentsState extends Equatable {
  final AppointmentFilter selectedFilter;
  final List<MockAppointment> appointments;

  const AdminAppointmentsState({
    this.selectedFilter = AppointmentFilter.upcoming,
    this.appointments = const [],
  });

  AdminAppointmentsState copyWith({
    AppointmentFilter? selectedFilter,
    List<MockAppointment>? appointments,
  }) {
    return AdminAppointmentsState(
      selectedFilter: selectedFilter ?? this.selectedFilter,
      appointments: appointments ?? this.appointments,
    );
  }

  @override
  List<Object> get props => [selectedFilter, appointments];
}
