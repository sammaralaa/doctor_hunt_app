import 'dart:io';

abstract class CreateDoctorEvent {
  const CreateDoctorEvent();
}

class CreateNewDoctorEvent extends CreateDoctorEvent {
  final String name;
  final String specialty;
  final double consultationFee;
  final File? imageFile;

  CreateNewDoctorEvent({
    required this.name,
    required this.specialty,
    required this.consultationFee,
    this.imageFile,
  });
}
