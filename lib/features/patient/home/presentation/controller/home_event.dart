import 'dart:io';

import 'package:doctor_hunt_app/features/patient/home/data/patient_model.dart';
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}
class UploadProfileImageEvent extends HomeEvent {
  final File imageFile;

  const UploadProfileImageEvent(this.imageFile);

  @override
  List<Object?> get props => [imageFile];
}

class GetUserProfileDataEvent extends HomeEvent{
  final PatientModel model;
  const GetUserProfileDataEvent(this.model);

  @override
    List<Object?> get props => [model];

}