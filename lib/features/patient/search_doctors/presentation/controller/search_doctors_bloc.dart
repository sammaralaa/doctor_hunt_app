import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_hunt_app/features/patient/search_doctors/data/repos/search_doctors_repository.dart';
import 'search_doctors_event.dart';
import 'search_doctors_state.dart';

class SearchDoctorsBloc extends Bloc<SearchDoctorsEvent, SearchDoctorsState> {
  final SearchDoctorsRepository repository;

  SearchDoctorsBloc({required this.repository})
      : super(const SearchDoctorsInitialState()) {
    on<SearchQueryChangedEvent>(_onSearchQueryChanged);
    on<ClearSearchEvent>(_onClearSearch);
  }

  Future<void> _onSearchQueryChanged(
    SearchQueryChangedEvent event,
    Emitter<SearchDoctorsState> emit,
  ) async {
    final query = event.query.trim();
    if (query.isEmpty) {
      emit(const SearchDoctorsInitialState());
      return;
    }

    emit(const SearchDoctorsLoadingState());

    try {
      final results = await repository.searchDoctors(query);
      if (results.isEmpty) {
        emit(const SearchDoctorsEmptyState());
      } else {
        emit(SearchDoctorsLoadedState(results));
      }
    } catch (e) {
      emit(SearchDoctorsErrorState(e.toString()));
    }
  }

  void _onClearSearch(
    ClearSearchEvent event,
    Emitter<SearchDoctorsState> emit,
  ) {
    emit(const SearchDoctorsInitialState());
  }
}
