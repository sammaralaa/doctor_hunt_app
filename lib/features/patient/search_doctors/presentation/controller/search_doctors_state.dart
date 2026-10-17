import 'package:equatable/equatable.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';

abstract class SearchDoctorsState extends Equatable {
  const SearchDoctorsState();

  @override
  List<Object?> get props => [];
}

class SearchDoctorsInitialState extends SearchDoctorsState {
  const SearchDoctorsInitialState();
}

class SearchDoctorsLoadingState extends SearchDoctorsState {
  const SearchDoctorsLoadingState();
}

class SearchDoctorsLoadedState extends SearchDoctorsState {
  final List<DoctorModel> doctors;

  const SearchDoctorsLoadedState(this.doctors);

  @override
  List<Object?> get props => [doctors];
}

class SearchDoctorsEmptyState extends SearchDoctorsState {
  const SearchDoctorsEmptyState();
}

class SearchDoctorsErrorState extends SearchDoctorsState {
  final String errorMessage;

  const SearchDoctorsErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
