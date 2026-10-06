

import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';
import 'package:doctor_hunt_app/features/admin/doctors_list/data/repos/doctors_list_repository.dart';
import 'package:doctor_hunt_app/features/admin/doctors_list/presentation/controller/doctors_list_event.dart';
import 'package:doctor_hunt_app/features/admin/doctors_list/presentation/controller/doctors_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorsListBloc extends Bloc<DoctorsListEvent, DoctorsListState> {
  final DoctorsListRepository _doctorsListRepository;

  DoctorsListBloc(this._doctorsListRepository)
    : super(DoctorsListInitialState()) {
    on<GetAllDoctorsEvent>(_onGetDoctors);
    on<FilterByCategoryEvent>(_onFilterByCategory);
    //on<GetUserProfileDataEvent>(_onGetUserProfileData);
  }

  Future<void> _onGetDoctors(
    GetAllDoctorsEvent event,
    Emitter<DoctorsListState> emit,
  ) async {
    emit(DoctorsListLoadingState());
    try {
      await emit.forEach<List<DoctorModel>>(
      _doctorsListRepository.getDoctors(),
      onData: (doctors) {
        String currentCategory = 'All';
        if (state is DoctorsListSuccessState) {
          currentCategory = (state as DoctorsListSuccessState).selectedCategory;
        }
        
        List<DoctorModel> filtered = doctors;
        if (currentCategory != 'All' && currentCategory.isNotEmpty) {
          filtered = doctors.where((d) => d.specialty.toLowerCase() == currentCategory.toLowerCase()).toList();
        }

        return DoctorsListSuccessState(
          allDoctors: doctors,
          filteredDoctors: filtered,
          selectedCategory: currentCategory,
        );
      },
      onError: (error, stackTrace) {
        return DoctorsListFailureState(error.toString());
      },
    );
    } catch (e) {
      emit(DoctorsListFailureState(e.toString()));
    }
  }

  void _onFilterByCategory(
    FilterByCategoryEvent event,
    Emitter<DoctorsListState> emit,
  ) {
    if (state is DoctorsListSuccessState) {
      final currentState = state as DoctorsListSuccessState;
      final allDoctors = currentState.allDoctors;
      
      List<DoctorModel> filtered = allDoctors;
      // We assume event.category is the filter term. 
      // In the screen, t.all is used, so we check if it's the "All" category.
      // But since we don't have access to context here, the screen can pass a special marker like 'All' or empty string.
      if (event.category != 'All' && event.category.isNotEmpty) {
        // Simple case-insensitive exact match for now. Or contains if preferable.
        // It's safer to use contains in case the specialty is "Cardiology" but category is "Cardiologist".
        filtered = allDoctors.where((d) => 
          d.specialty.toLowerCase().contains(event.category.toLowerCase()) || 
          event.category.toLowerCase().contains(d.specialty.toLowerCase())
        ).toList();
      }

      emit(DoctorsListSuccessState(
        allDoctors: allDoctors,
        filteredDoctors: filtered,
        selectedCategory: event.category,
      ));
    }
  }
}
