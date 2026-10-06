import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';

abstract class DoctorsListState {}

class DoctorsListInitialState extends DoctorsListState {}

class DoctorsListLoadingState extends DoctorsListState {}

class DoctorsListSuccessState extends DoctorsListState {
  final List<DoctorModel> allDoctors;
  final List<DoctorModel> filteredDoctors;
  final String selectedCategory;

  DoctorsListSuccessState({
    required this.allDoctors,
    required this.filteredDoctors,
    required this.selectedCategory,
  });
}

class DoctorsListFailureState extends DoctorsListState {
  final String errorMessage;

  DoctorsListFailureState(this.errorMessage);
}
