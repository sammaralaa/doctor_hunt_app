import 'package:equatable/equatable.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';

abstract class PopularDoctorsState extends Equatable {
  const PopularDoctorsState();

  @override
  List<Object?> get props => [];
}

class PopularDoctorsInitialState extends PopularDoctorsState {
  const PopularDoctorsInitialState();
}

class PopularDoctorsLoadingState extends PopularDoctorsState {
  const PopularDoctorsLoadingState();
}

class PopularDoctorsLoadedState extends PopularDoctorsState {
  final List<DoctorModel> doctors;

  const PopularDoctorsLoadedState(this.doctors);

  @override
  List<Object?> get props => [doctors];
}

class PopularDoctorsErrorState extends PopularDoctorsState {
  final String errorMessage;

  const PopularDoctorsErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
