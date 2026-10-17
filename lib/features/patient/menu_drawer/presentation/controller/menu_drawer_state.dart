import 'package:equatable/equatable.dart';
import 'package:doctor_hunt_app/core/models/patient_model.dart';

abstract class MenuDrawerState extends Equatable {
  const MenuDrawerState();

  @override
  List<Object?> get props => [];
}

class MenuDrawerInitialState extends MenuDrawerState {
  const MenuDrawerInitialState();
}

class MenuDrawerLoadingState extends MenuDrawerState {
  const MenuDrawerLoadingState();
}

class MenuDrawerLoadedState extends MenuDrawerState {
  final PatientModel patient;

  const MenuDrawerLoadedState({required this.patient});

  @override
  List<Object?> get props => [patient];
}

class MenuDrawerErrorState extends MenuDrawerState {
  final String errorMessage;

  const MenuDrawerErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class MenuLogoutLoadingState extends MenuDrawerState {
  const MenuLogoutLoadingState();
}

class MenuLogoutSuccessState extends MenuDrawerState {
  const MenuLogoutSuccessState();
}

class MenuLogoutErrorState extends MenuDrawerState {
  final String errorMessage;

  const MenuLogoutErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
