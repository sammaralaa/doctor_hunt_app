import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';

abstract class AdminDocDetailsState {}

class DoctorDetailsInitialState extends AdminDocDetailsState {}

class DoctorDetailsLoadingState extends AdminDocDetailsState {}

class FetchDoctorDetailsSuccessState extends AdminDocDetailsState {
  final DoctorModel doctor;
  FetchDoctorDetailsSuccessState({required this.doctor});
}

class ChangeStatusSuccessState extends AdminDocDetailsState {
  final String doctorId;
  final bool newStatus;

  ChangeStatusSuccessState({required this.doctorId, required this.newStatus});
}

class DeleteDoctorSuccessState extends AdminDocDetailsState {}

class DoctorDetailsFailureState extends AdminDocDetailsState {
  final String errorMessage;

  DoctorDetailsFailureState(this.errorMessage);
}
