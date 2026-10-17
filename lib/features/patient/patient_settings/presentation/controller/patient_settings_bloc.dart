import 'package:doctor_hunt_app/core/services/shared_prefs_service.dart';
import 'package:doctor_hunt_app/features/patient/patient_settings/data/repos/patient_settings_repository.dart';
import 'package:doctor_hunt_app/features/patient/patient_settings/presentation/controller/patient_settings_event.dart';
import 'package:doctor_hunt_app/features/patient/patient_settings/presentation/controller/patient_settings_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientSettingsBloc
    extends Bloc<PatientSettingsEvent, PatientSettingsState> {
  final PatientSettingsRepository _repository;

  PatientSettingsBloc(this._repository)
      : super(const PatientSettingsInitialState()) {
    on<LoadPatientSettingsEvent>(_onLoadPatientSettings);
    on<PatientLogoutEvent>(_onPatientLogout);
  }

  Future<void> _onLoadPatientSettings(
    LoadPatientSettingsEvent event,
    Emitter<PatientSettingsState> emit,
  ) async {
    emit(const PatientSettingsLoadingState());
    try {
      final profile = await _repository.fetchPatientProfile();
      emit(PatientSettingsLoadedState(patientProfile: profile));
    } catch (e) {
      emit(PatientSettingsErrorState(e.toString()));
    }
  }

  Future<void> _onPatientLogout(
    PatientLogoutEvent event,
    Emitter<PatientSettingsState> emit,
  ) async {
    emit(const PatientLogoutLoadingState());
    try {
      await FirebaseAuth.instance.signOut();
      await SharedPrefsService.setIsLoggedIn(false);
      await SharedPrefsService.setUserRole('');
      emit(const PatientLogoutSuccessState());
    } catch (e) {
      emit(PatientLogoutErrorState(e.toString()));
    }
  }
}
