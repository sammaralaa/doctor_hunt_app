import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_hunt_app/features/patient/popular_doctors/data/repos/popular_doctors_repository.dart';
import 'package:doctor_hunt_app/features/patient/popular_doctors/presentation/controller/popular_doctors_event.dart';
import 'package:doctor_hunt_app/features/patient/popular_doctors/presentation/controller/popular_doctors_state.dart';

class PopularDoctorsBloc
    extends Bloc<PopularDoctorsEvent, PopularDoctorsState> {
  final PopularDoctorsRepository repository;

  PopularDoctorsBloc({required this.repository})
      : super(const PopularDoctorsInitialState()) {
    on<FetchPopularDoctorsEvent>(_onFetchPopularDoctors);
  }

  Future<void> _onFetchPopularDoctors(
    FetchPopularDoctorsEvent event,
    Emitter<PopularDoctorsState> emit,
  ) async {
    emit(const PopularDoctorsLoadingState());
    try {
      final doctors = await repository.getPopularDoctors();
      emit(PopularDoctorsLoadedState(doctors));
    } catch (e) {
      emit(PopularDoctorsErrorState(e.toString()));
    }
  }
}
