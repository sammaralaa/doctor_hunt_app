import 'package:doctor_hunt_app/features/admin/admin_settings/data/repos/admin_settings_repository.dart';
import 'package:doctor_hunt_app/features/admin/admin_settings/presentation/controller/admin_settings_event.dart';
import 'package:doctor_hunt_app/features/admin/admin_settings/presentation/controller/admin_settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminSettingsBloc extends Bloc<AdminSettingsEvent, AdminSettingsState> {
  // ignore: unused_field
  final AdminSettingsRepository _repository;

  AdminSettingsBloc(this._repository) : super(const AdminSettingsInitialState());
}
