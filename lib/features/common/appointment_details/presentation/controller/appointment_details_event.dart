import 'package:equatable/equatable.dart';

abstract class AppointmentDetailsEvent extends Equatable {
  const AppointmentDetailsEvent();

  @override
  List<Object?> get props => [];
}

class FetchAppointmentDetailsEvent extends AppointmentDetailsEvent {
  final String appointmentId;

  const FetchAppointmentDetailsEvent(this.appointmentId);

  @override
  List<Object?> get props => [appointmentId];
}

class CancelAppointmentDetailEvent extends AppointmentDetailsEvent {
  final String appointmentId;

  const CancelAppointmentDetailEvent(this.appointmentId);

  @override
  List<Object?> get props => [appointmentId];
}

class MarkAppointmentCompletedDetailEvent extends AppointmentDetailsEvent {
  final String appointmentId;

  const MarkAppointmentCompletedDetailEvent(this.appointmentId);

  @override
  List<Object?> get props => [appointmentId];
}
