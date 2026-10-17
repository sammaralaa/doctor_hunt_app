import 'package:equatable/equatable.dart';

abstract class PatientSettingsEvent extends Equatable {
  const PatientSettingsEvent();

  @override
  List<Object?> get props => [];
}

class LoadPatientSettingsEvent extends PatientSettingsEvent {
  const LoadPatientSettingsEvent();
}

class PatientLogoutEvent extends PatientSettingsEvent {
  const PatientLogoutEvent();
}
