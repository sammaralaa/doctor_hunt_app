import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:doctor_hunt_app/core/models/patient_model.dart';

abstract class PatientProfileState extends Equatable {
  const PatientProfileState();

  @override
  List<Object?> get props => [];
}

class PatientProfileInitialState extends PatientProfileState {
  const PatientProfileInitialState();
}

class PatientProfileLoadingState extends PatientProfileState {
  const PatientProfileLoadingState();
}

class PatientProfileLoadedState extends PatientProfileState {
  final PatientModel patient;
  final File? pickedImage;

  const PatientProfileLoadedState({
    required this.patient,
    this.pickedImage,
  });

  PatientProfileLoadedState copyWith({
    PatientModel? patient,
    File? pickedImage,
    bool clearPickedImage = false,
  }) {
    return PatientProfileLoadedState(
      patient: patient ?? this.patient,
      pickedImage: clearPickedImage ? null : (pickedImage ?? this.pickedImage),
    );
  }

  @override
  List<Object?> get props => [patient, pickedImage?.path];
}

class PatientProfileUpdatingState extends PatientProfileState {
  final PatientModel patient;
  final File? pickedImage;

  const PatientProfileUpdatingState({
    required this.patient,
    this.pickedImage,
  });

  @override
  List<Object?> get props => [patient, pickedImage?.path];
}

class PatientProfileUpdateSuccessState extends PatientProfileState {
  final PatientModel patient;

  const PatientProfileUpdateSuccessState({required this.patient});

  @override
  List<Object?> get props => [patient];
}

class PatientProfileErrorState extends PatientProfileState {
  final String errorMessage;

  const PatientProfileErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
