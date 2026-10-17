import 'package:equatable/equatable.dart';

abstract class PatientAppointmentsEvent extends Equatable {
  const PatientAppointmentsEvent();

  @override
  List<Object?> get props => [];
}

class FetchPatientAppointmentsEvent extends PatientAppointmentsEvent {
  const FetchPatientAppointmentsEvent();
}

class CancelAppointmentEvent extends PatientAppointmentsEvent {
  final String appointmentId;

  const CancelAppointmentEvent(this.appointmentId);

  @override
  List<Object?> get props => [appointmentId];
}
