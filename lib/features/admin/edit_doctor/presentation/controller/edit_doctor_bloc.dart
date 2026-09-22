import 'package:doctor_hunt_app/features/admin/edit_doctor/data/repos/edit_doctor_repository.dart';
import 'package:doctor_hunt_app/features/admin/edit_doctor/presentation/controller/edit_doctor_event.dart';
import 'package:doctor_hunt_app/features/admin/edit_doctor/presentation/controller/edit_doctor_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditDoctorBloc extends Bloc<EditDoctorEvent, EditDoctorState> {
  final EditDoctorRepository _editDoctorRepository;

  EditDoctorBloc(this._editDoctorRepository)
    : super(EditDoctorInitialState()) {
    on<FetchDoctorDetailsEvent>(_onFetchDoctorDetails);
   
    //on<GetUserProfileDataEvent>(_onGetUserProfileData);
  }

  Future<void> _onFetchDoctorDetails(
  FetchDoctorDetailsEvent event,
  Emitter<EditDoctorState> emit,
) async {
  emit(FetchDoctorLoadingState());

  try {
    final doctor = await _editDoctorRepository.getDoctorById(event.doctorId);
    emit(FetchDoctorSuccessState(doctor: doctor));
  } catch (e) {
    emit(FetchDoctorFailureState(errorMessage: e.toString()));
  }
}
}
