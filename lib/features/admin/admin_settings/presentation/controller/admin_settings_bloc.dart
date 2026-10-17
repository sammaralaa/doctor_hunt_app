import 'package:doctor_hunt_app/core/services/shared_prefs_service.dart';
import 'package:doctor_hunt_app/features/admin/admin_settings/data/repos/admin_settings_repository.dart';
import 'package:doctor_hunt_app/features/admin/admin_settings/presentation/controller/admin_settings_event.dart';
import 'package:doctor_hunt_app/features/admin/admin_settings/presentation/controller/admin_settings_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminSettingsBloc extends Bloc<AdminSettingsEvent, AdminSettingsState> {
  final AdminSettingsRepository _repository;

  AdminSettingsBloc(this._repository)
      : super(const AdminSettingsInitialState()) {
    on<LoadAdminSettingsEvent>(_onLoadAdminSettings);
    on<AdminLogoutEvent>(_onAdminLogout);
  }

  Future<void> _onLoadAdminSettings(
    LoadAdminSettingsEvent event,
    Emitter<AdminSettingsState> emit,
  ) async {
    emit(const AdminSettingsLoadingState());
    try {
      final profile = await _repository.fetchAdminProfile();
      emit(AdminSettingsLoadedState(adminProfile: profile));
    } catch (e) {
      emit(AdminSettingsErrorState(e.toString()));
    }
  }

  Future<void> _onAdminLogout(
    AdminLogoutEvent event,
    Emitter<AdminSettingsState> emit,
  ) async {
    emit(const AdminLogoutLoadingState());
    try {
      await FirebaseAuth.instance.signOut();
      await SharedPrefsService.setIsLoggedIn(false);
      await SharedPrefsService.setUserRole('');
      emit(const LogoutSuccessState());
    } catch (e) {
      emit(AdminLogoutErrorState(e.toString()));
    }
  }
}
