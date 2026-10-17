import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class PatientProfileEvent extends Equatable {
  const PatientProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadPatientProfileEvent extends PatientProfileEvent {
  const LoadPatientProfileEvent();
}

class PickPatientProfileImageEvent extends PatientProfileEvent {
  final File imageFile;

  const PickPatientProfileImageEvent(this.imageFile);

  @override
  List<Object?> get props => [imageFile.path];
}

class UpdatePatientProfileEvent extends PatientProfileEvent {
  final String name;
  final String phoneNumber;
  final File? imageFile;

  const UpdatePatientProfileEvent({
    required this.name,
    required this.phoneNumber,
    this.imageFile,
  });

  @override
  List<Object?> get props => [name, phoneNumber, imageFile?.path];
}
