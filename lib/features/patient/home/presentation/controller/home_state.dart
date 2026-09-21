import 'package:doctor_hunt_app/features/patient/home/data/model/patient_model.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {

  @override
  List<Object?> get props => [];
}
class HomeInitialState extends HomeState {}
class ProfileImageLoadingState extends HomeState {}
class ProfileImageSuccessState extends HomeState {
  final PatientModel model;

   ProfileImageSuccessState( this.model);

  @override
  List<Object?> get props => [model];
}
class ProfileImageFailureState extends HomeState {
  final String errorMessage;

   ProfileImageFailureState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class UserProfileLoadingState extends HomeState {}

class UserProfileSuccessState extends HomeState {
  final PatientModel user;

   UserProfileSuccessState(this.user);

  @override
  List<Object?> get props => [user];
}

class UserProfileFailureState extends HomeState {
  final String errorMessage;

   UserProfileFailureState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}