import 'dart:async';
import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';
import 'package:doctor_hunt_app/features/patient/favorite/data/repos/favorites_repository.dart';
import 'package:doctor_hunt_app/features/patient/favorite/presentation/controller/favorites_event.dart';
import 'package:doctor_hunt_app/features/patient/favorite/presentation/controller/favorites_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesRepository _favoritesRepository;
  StreamSubscription<List<DoctorModel>>? _favoritesSubscription;

  FavoritesBloc(this._favoritesRepository)
      : super(const FavoritesInitialState()) {
    on<FetchFavoriteDoctorsEvent>(_onFetchFavoriteDoctors);
    on<ToggleFavoriteDoctorEvent>(_onToggleFavoriteDoctor);
    on<FavoritesUpdatedEvent>(_onFavoritesUpdated);
    on<FavoritesErrorOccurredEvent>(_onFavoritesErrorOccurred);
  }

  Future<void> _onFetchFavoriteDoctors(
    FetchFavoriteDoctorsEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(const FavoritesLoadingState());
    await _favoritesSubscription?.cancel();
    _favoritesSubscription = _favoritesRepository.getFavoriteDoctors().listen(
      (doctors) {
        add(FavoritesUpdatedEvent(doctors));
      },
      onError: (error) {
        add(FavoritesErrorOccurredEvent(error.toString()));
      },
    );
  }

  void _onFavoritesUpdated(
    FavoritesUpdatedEvent event,
    Emitter<FavoritesState> emit,
  ) {
    if (event.doctors.isEmpty) {
      emit(const FavoritesEmptyState());
    } else {
      final ids = event.doctors
          .map((d) => d.id)
          .whereType<String>()
          .toSet();
      emit(FavoritesSuccessState(
        favoriteDoctors: event.doctors,
        favoriteIds: ids,
      ));
    }
  }

  void _onFavoritesErrorOccurred(
    FavoritesErrorOccurredEvent event,
    Emitter<FavoritesState> emit,
  ) {
    emit(FavoritesErrorState(event.errorMessage));
  }

  Future<void> _onToggleFavoriteDoctor(
    ToggleFavoriteDoctorEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    final doctorId = event.doctor.id;
    if (doctorId == null) return;

    final currentState = state;
    final isFav = isDoctorFavorite(doctorId);

    try {
      if (isFav) {
        await _favoritesRepository.removeDoctorFromFavorites(doctorId);
      } else {
        await _favoritesRepository.addDoctorToFavorites(event.doctor);
      }
    } catch (e) {
      emit(FavoritesErrorState(e.toString()));
      if (currentState is FavoritesSuccessState ||
          currentState is FavoritesEmptyState) {
        emit(currentState);
      }
    }
  }

  bool isDoctorFavorite(String? doctorId) {
    if (doctorId == null) return false;
    final currentState = state;
    if (currentState is FavoritesSuccessState) {
      return currentState.isFavorite(doctorId);
    }
    return false;
  }

  @override
  Future<void> close() {
    _favoritesSubscription?.cancel();
    return super.close();
  }
}
