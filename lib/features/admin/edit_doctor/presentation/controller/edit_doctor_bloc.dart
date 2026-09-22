import 'package:doctor_hunt_app/features/admin/edit_doctor/data/repos/edit_doctor_repository.dart';
import 'package:doctor_hunt_app/features/admin/edit_doctor/presentation/controller/edit_doctor_event.dart';
import 'package:doctor_hunt_app/features/admin/edit_doctor/presentation/controller/edit_doctor_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditDoctorBloc extends Bloc<EditDoctorEvent, EditDoctorState> {
  final EditDoctorRepository _editDoctorRepository;

  EditDoctorBloc(this._editDoctorRepository) : super(EditDoctorInitialState()) {
    on<FetchDoctorDetailsEvent>(_onFetchDoctorDetails);
    on<UpdateDoctorDetailsEvent>(_onUpdateDoctorDetails);
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

  Future<void> _onUpdateDoctorDetails(
    UpdateDoctorDetailsEvent event,
    Emitter<EditDoctorState> emit,
  ) async {
    emit(UpdateDoctorLoadingState());

    try {
      String? imageUrl;
      // if (event.imageFile != null) {
      //   imageUrl = await uploadImageToStorage(event.imageFile!);
      // }

      await _editDoctorRepository.updateDoctor(
        doctorId: event.doctorId,
        name: event.name,
        specialty: event.specialty,
        imageUrl: imageUrl,
        isActive: event.isActive
      );

      emit(UpdateDoctorSuccessState());
    } catch (e) {
      emit(UpdateDoctorFailureState(errorMessage: e.toString()));
    }
  }
}
