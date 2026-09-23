import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';

abstract class EditDoctorState {}

class EditDoctorInitialState extends EditDoctorState {}

class FetchDoctorLoadingState extends EditDoctorState {}

class FetchDoctorSuccessState extends EditDoctorState {
  final DoctorModel doctor;
  final String? newImagePath;
  final bool? isActive;
  FetchDoctorSuccessState({required this.doctor, this.newImagePath, this.isActive});
  FetchDoctorSuccessState copyWith({
    DoctorModel? doctor,
    String? newImagePath,
    bool? isActive,
  }) {
    return FetchDoctorSuccessState(
      doctor: doctor ?? this.doctor,
      newImagePath: newImagePath ?? this.newImagePath,
      isActive: isActive ?? this.isActive,
    );
  }
}

class FetchDoctorFailureState extends EditDoctorState {
  final String errorMessage;
  FetchDoctorFailureState({required this.errorMessage});
}


class UpdateDoctorLoadingState extends EditDoctorState {}

class UpdateDoctorSuccessState extends EditDoctorState {}

class UpdateDoctorFailureState extends EditDoctorState {
  final String errorMessage;
  UpdateDoctorFailureState({required this.errorMessage});
}
