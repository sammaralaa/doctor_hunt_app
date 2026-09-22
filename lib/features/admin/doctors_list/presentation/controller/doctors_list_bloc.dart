

import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';
import 'package:doctor_hunt_app/features/admin/doctors_list/data/repos/doctors_list_repository.dart';
import 'package:doctor_hunt_app/features/admin/doctors_list/presentation/controller/doctors_list_event.dart';
import 'package:doctor_hunt_app/features/admin/doctors_list/presentation/controller/doctors_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorsListBloc extends Bloc<DoctorsListEvent, DoctorsListState> {
  final DoctorsListRepository _DoctorsListRepository;

  DoctorsListBloc(this._DoctorsListRepository)
    : super(DoctorsListInitialState()) {
    on<GetAllDoctorsEvent>(_onGetDoctors);
    //on<GetUserProfileDataEvent>(_onGetUserProfileData);
  }

  Future<void> _onGetDoctors(
    GetAllDoctorsEvent event,
    Emitter<DoctorsListState> emit,
  ) async {
    emit(DoctorsListLoadingState());
    try {
      // final List<DoctorModel> doctorsList =await _DoctorsListRepository.getDoctors();
      // emit(DoctorsListSuccessState(doctorsList));
      await emit.forEach<List<DoctorModel>>(
      _DoctorsListRepository.getDoctors(),
      onData: (doctors) {
       // final activeCount = doctors.where((d) => d.isActive).length;
        return DoctorsListSuccessState( doctors,);
      },
      onError: (error, stackTrace) {
        return DoctorsListFailureState(error.toString());
      },
    );
    } catch (e) {
      emit(DoctorsListFailureState(e.toString()));
    }
  }
}
