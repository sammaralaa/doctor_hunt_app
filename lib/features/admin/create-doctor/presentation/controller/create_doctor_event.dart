import 'dart:io';


abstract class CreateDoctorEvent  {
  const CreateDoctorEvent();
}
class CreateNewDoctorEvent extends CreateDoctorEvent {
  final String name;
  final String specialty;
  final File? imageFile;

  CreateNewDoctorEvent({
    required this.name,
    required this.specialty,
    this.imageFile,
  });
}
