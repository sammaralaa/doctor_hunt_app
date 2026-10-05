import 'package:doctor_hunt_app/features/admin/admin_appointments/data/repos/admin_appointments_repository.dart';
import 'package:doctor_hunt_app/features/admin/admin_appointments/presentation/controller/admin_appointments_event.dart';
import 'package:doctor_hunt_app/features/admin/admin_appointments/presentation/controller/admin_appointments_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminAppointmentsBloc
    extends Bloc<AdminAppointmentsEvent, AdminAppointmentsState> {
  // ignore: unused_field
  final AdminAppointmentsRepository _repository;

  AdminAppointmentsBloc(this._repository)
      : super(const AdminAppointmentsInitialState());
}
