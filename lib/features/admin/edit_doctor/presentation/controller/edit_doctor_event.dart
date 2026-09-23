import 'dart:io';

import 'package:doctor_hunt_app/core/utils/doctor_specialty_enum.dart';

abstract class EditDoctorEvent {
  const EditDoctorEvent();
}

class FetchDoctorDetailsEvent extends EditDoctorEvent {
  final String doctorId;
  FetchDoctorDetailsEvent({required this.doctorId});
}

class UpdateDoctorDetailsEvent extends EditDoctorEvent {
  final String doctorId;
  final String name;
  final DoctorSpecialty specialty;
  final String? imageFile;
  final bool isActive;
  UpdateDoctorDetailsEvent({
    required this.doctorId,
    required this.name,
    required this.specialty,
    this.imageFile,
    required this.isActive,
  });
}

class ChangeDoctorImageEvent extends EditDoctorEvent {
  final String imagePath;
  ChangeDoctorImageEvent({required this.imagePath});
}

class ToggleDoctorStatusEvent extends EditDoctorEvent {
  final bool isActive;
  ToggleDoctorStatusEvent({required this.isActive});
}
