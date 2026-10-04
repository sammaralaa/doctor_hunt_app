import 'package:equatable/equatable.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class FetchFavoriteDoctorsEvent extends FavoritesEvent {
  const FetchFavoriteDoctorsEvent();
}

class ToggleFavoriteDoctorEvent extends FavoritesEvent {
  final DoctorModel doctor;

  const ToggleFavoriteDoctorEvent(this.doctor);

  @override
  List<Object?> get props => [doctor];
}

class FavoritesUpdatedEvent extends FavoritesEvent {
  final List<DoctorModel> doctors;

  const FavoritesUpdatedEvent(this.doctors);

  @override
  List<Object?> get props => [doctors];
}

class FavoritesErrorOccurredEvent extends FavoritesEvent {
  final String errorMessage;

  const FavoritesErrorOccurredEvent(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
