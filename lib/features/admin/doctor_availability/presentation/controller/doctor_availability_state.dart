import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';
import 'package:doctor_hunt_app/features/admin/doctor_availability/data/model/doctor_availability_model.dart';
import 'package:equatable/equatable.dart';

abstract class DoctorAvailabilityState extends Equatable {
  const DoctorAvailabilityState();

  @override
  List<Object?> get props => [];
}

class DoctorAvailabilityInitialState extends DoctorAvailabilityState {
  const DoctorAvailabilityInitialState();
}

class DoctorAvailabilityLoadingState extends DoctorAvailabilityState {
  const DoctorAvailabilityLoadingState();
}

class DoctorAvailabilityLoadedState extends DoctorAvailabilityState {
  final DoctorModel doctor;
  final DoctorAvailabilityModel availability;
  final bool isSaving;
  final bool saveSuccess;
  final String? errorMessage;

  const DoctorAvailabilityLoadedState({
    required this.doctor,
    required this.availability,
    this.isSaving = false,
    this.saveSuccess = false,
    this.errorMessage,
  });

  DoctorAvailabilityLoadedState copyWith({
    DoctorModel? doctor,
    DoctorAvailabilityModel? availability,
    bool? isSaving,
    bool? saveSuccess,
    String? errorMessage,
  }) {
    return DoctorAvailabilityLoadedState(
      doctor: doctor ?? this.doctor,
      availability: availability ?? this.availability,
      isSaving: isSaving ?? this.isSaving,
      saveSuccess: saveSuccess ?? this.saveSuccess,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        doctor,
        availability,
        isSaving,
        saveSuccess,
        errorMessage,
      ];
}

class DoctorAvailabilityFailureState extends DoctorAvailabilityState {
  final String errorMessage;

  const DoctorAvailabilityFailureState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
