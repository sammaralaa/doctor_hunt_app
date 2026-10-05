import 'package:equatable/equatable.dart';

abstract class AdminAppointmentsState extends Equatable {
  const AdminAppointmentsState();

  @override
  List<Object?> get props => [];
}

class AdminAppointmentsInitialState extends AdminAppointmentsState {
  const AdminAppointmentsInitialState();
}
