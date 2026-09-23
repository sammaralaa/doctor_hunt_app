import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';
import 'package:doctor_hunt_app/features/patient/home/data/model/patient_model.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class FetchDoctorsLoadingState extends HomeState {}

class FetchDoctorsSuccessState extends HomeState {
  final List<DoctorModel> doctorsData;
  FetchDoctorsSuccessState({required this.doctorsData});
}
class FetchDoctorsFailureState extends HomeState{
  final String errorMessage;
  FetchDoctorsFailureState(this.errorMessage);
}
class UserProfileLoadingState extends HomeState {}

class UserProfileSuccessState extends HomeState {
  final PatientModel user;

  UserProfileSuccessState(this.user);
}

class UserProfileFailureState extends HomeState {
  final String errorMessage;
  UserProfileFailureState(this.errorMessage);
}
