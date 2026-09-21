import 'package:doctor_hunt_app/features/admin/create-doctor/data/repos/create_doctor_repository.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/presentation/controller/Create_doctor_state.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/presentation/controller/create_doctor_event.dart';
import 'package:doctor_hunt_app/features/patient/home/presentation/controller/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateDoctorBloc extends Bloc<CreateDoctorEvent, CreateDoctorState> {
  final CreateDoctorRepository _createDoctorRepository;

  CreateDoctorBloc(this._createDoctorRepository)
    : super(CreateDoctorInitialState()) {
    on<CreateNewDoctorEvent>(_onCreateNewDoctor);
    //on<GetUserProfileDataEvent>(_onGetUserProfileData);
  }

  Future<void> _onCreateNewDoctor(
    CreateNewDoctorEvent event,
    Emitter<CreateDoctorState> emit,
  ) async {
    emit(CreateDoctorLoadingState());
    try {
      await _createDoctorRepository.createDoctor(
        name: event.name,
        specialty: event.specialty,
        imageFile: event.imageFile,
      );
      emit(CreateDoctorSuccessState());
    } catch (e) {
      emit(CreateDoctorFailureState(e.toString()));
    }
  }
}
