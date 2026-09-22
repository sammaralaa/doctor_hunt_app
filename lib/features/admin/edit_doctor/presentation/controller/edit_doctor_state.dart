import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';

abstract class EditDoctorState {}

class EditDoctorInitialState extends EditDoctorState {}

class FetchDoctorLoadingState extends EditDoctorState {}

class FetchDoctorSuccessState extends EditDoctorState {
  final DoctorModel doctor;
  FetchDoctorSuccessState({required this.doctor});
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
