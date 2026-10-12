import 'package:equatable/equatable.dart';
import 'admin_appointments_state.dart';

abstract class AdminAppointmentsEvent extends Equatable {
  const AdminAppointmentsEvent();

  @override
  List<Object> get props => [];
}

class ChangeFilterEvent extends AdminAppointmentsEvent {
  final AppointmentFilter filter;

  const ChangeFilterEvent(this.filter);

  @override
  List<Object> get props => [filter];
}

class LoadAppointmentsEvent extends AdminAppointmentsEvent {}
