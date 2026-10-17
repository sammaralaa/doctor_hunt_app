import 'package:equatable/equatable.dart';
import 'package:doctor_hunt_app/features/admin/admin_appointments/presentation/controller/admin_appointments_state.dart';

abstract class AdminAppointmentsEvent extends Equatable {
  const AdminAppointmentsEvent();

  @override
  List<Object?> get props => [];
}

class LoadAdminAppointmentsEvent extends AdminAppointmentsEvent {
  const LoadAdminAppointmentsEvent();
}

// Backwards-compatible alias for existing UI
class LoadAppointmentsEvent extends LoadAdminAppointmentsEvent {
  const LoadAppointmentsEvent();
}

class ChangeFilterEvent extends AdminAppointmentsEvent {
  final AppointmentFilter filter;

  const ChangeFilterEvent(this.filter);

  @override
  List<Object?> get props => [filter];
}

class CancelAppointmentEvent extends AdminAppointmentsEvent {
  final String appointmentId;

  const CancelAppointmentEvent(this.appointmentId);

  @override
  List<Object?> get props => [appointmentId];
}

class MarkAsCompletedEvent extends AdminAppointmentsEvent {
  final String appointmentId;

  const MarkAsCompletedEvent(this.appointmentId);

  @override
  List<Object?> get props => [appointmentId];
}
