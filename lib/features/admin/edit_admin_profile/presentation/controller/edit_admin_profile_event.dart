import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class EditAdminProfileEvent extends Equatable {
  const EditAdminProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadAdminProfileEvent extends EditAdminProfileEvent {
  const LoadAdminProfileEvent();
}

class PickProfileImageEvent extends EditAdminProfileEvent {
  final File imageFile;

  const PickProfileImageEvent(this.imageFile);

  @override
  List<Object?> get props => [imageFile.path];
}

class UpdateAdminProfileEvent extends EditAdminProfileEvent {
  final String name;
  final String clinicLocation;
  final File? imageFile;

  const UpdateAdminProfileEvent({
    required this.name,
    required this.clinicLocation,
    this.imageFile,
  });

  @override
  List<Object?> get props => [name, clinicLocation, imageFile?.path];
}
