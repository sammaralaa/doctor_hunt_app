import 'package:doctor_hunt_app/features/patient/doctor_details/data/repos/doctor_details_repository.dart';
import 'package:doctor_hunt_app/features/patient/doctor_details/presentation/controller/doctor_details_event.dart';
import 'package:doctor_hunt_app/features/patient/doctor_details/presentation/controller/doctor_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorDetailsBloc extends Bloc<DoctorDetailsEvent,DoctorDetailsState>{
  final DoctorDetailsRepository _doctorDetailsRepository;

  DoctorDetailsBloc(this._doctorDetailsRepository) : super(DoctorDetailsInitialState()) {
    on<FetchDoctorDetailsEvent>(_onFetchDoctorDetails);
    
  }

 
  Future<void> _onFetchDoctorDetails(
    FetchDoctorDetailsEvent event,
    Emitter<DoctorDetailsState> emit,
  ) async {
    emit(DoctorDetailsLoadingState());
   
    try {
       final doctor = await _doctorDetailsRepository.getDoctorById(event.doctorId);
    emit(DoctorDetailsSuccessState(doctorData: doctor));
    } catch (e) {
      emit(DoctorDetailsFailureState(e.toString()));
    }
  }
  
}