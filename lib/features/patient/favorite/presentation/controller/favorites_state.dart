import 'package:equatable/equatable.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  Set<String> get favoriteDoctorIds => const {};
  Set<String> get favoriteIds => const {};

  bool isFavorite(String? doctorId) => false;

  @override
  List<Object?> get props => [];
}

class FavoritesInitialState extends FavoritesState {
  const FavoritesInitialState();
}

class FavoritesLoadingState extends FavoritesState {
  const FavoritesLoadingState();
}

class FavoritesSuccessState extends FavoritesState {
  final List<DoctorModel> favoriteDoctors;
  @override
  final Set<String> favoriteIds;

  const FavoritesSuccessState({
    required this.favoriteDoctors,
    required this.favoriteIds,
  });

  @override
  Set<String> get favoriteDoctorIds => favoriteIds;

  @override
  bool isFavorite(String? doctorId) {
    if (doctorId == null) return false;
    return favoriteIds.contains(doctorId);
  }

  @override
  List<Object?> get props => [favoriteDoctors, favoriteIds];
}

class FavoritesEmptyState extends FavoritesState {
  const FavoritesEmptyState();
}

class FavoritesErrorState extends FavoritesState {
  final String errorMessage;

  const FavoritesErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
