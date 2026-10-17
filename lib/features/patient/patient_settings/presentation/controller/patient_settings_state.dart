import 'package:doctor_hunt_app/core/models/patient_model.dart';
import 'package:equatable/equatable.dart';

abstract class PatientSettingsState extends Equatable {
  const PatientSettingsState();

  @override
  List<Object?> get props => [];
}

class PatientSettingsInitialState extends PatientSettingsState {
  const PatientSettingsInitialState();
}

class PatientSettingsLoadingState extends PatientSettingsState {
  const PatientSettingsLoadingState();
}

class PatientSettingsLoadedState extends PatientSettingsState {
  final PatientModel patientProfile;

  const PatientSettingsLoadedState({required this.patientProfile});

  @override
  List<Object?> get props => [patientProfile];
}

class PatientSettingsErrorState extends PatientSettingsState {
  final String errorMessage;

  const PatientSettingsErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class PatientLogoutLoadingState extends PatientSettingsState {
  const PatientLogoutLoadingState();
}

class PatientLogoutSuccessState extends PatientSettingsState {
  const PatientLogoutSuccessState();
}

typedef LogoutSuccess = PatientLogoutSuccessState;

class PatientLogoutErrorState extends PatientSettingsState {
  final String errorMessage;

  const PatientLogoutErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
