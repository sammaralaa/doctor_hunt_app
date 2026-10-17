import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_hunt_app/features/patient/patient_profile/data/repos/patient_profile_repository.dart';
import 'patient_profile_event.dart';
import 'patient_profile_state.dart';

class PatientProfileBloc
    extends Bloc<PatientProfileEvent, PatientProfileState> {
  final PatientProfileRepository repository;

  PatientProfileBloc({required this.repository})
      : super(const PatientProfileInitialState()) {
    on<LoadPatientProfileEvent>(_onLoadPatientProfile);
    on<PickPatientProfileImageEvent>(_onPickPatientProfileImage);
    on<UpdatePatientProfileEvent>(_onUpdatePatientProfile);
  }

  Future<void> _onLoadPatientProfile(
    LoadPatientProfileEvent event,
    Emitter<PatientProfileState> emit,
  ) async {
    emit(const PatientProfileLoadingState());
    try {
      final patient = await repository.fetchPatientProfile();
      emit(PatientProfileLoadedState(patient: patient));
    } catch (e) {
      emit(PatientProfileErrorState(e.toString()));
    }
  }

  void _onPickPatientProfileImage(
    PickPatientProfileImageEvent event,
    Emitter<PatientProfileState> emit,
  ) {
    if (state is PatientProfileLoadedState) {
      final current = state as PatientProfileLoadedState;
      emit(current.copyWith(pickedImage: event.imageFile));
    }
  }

  Future<void> _onUpdatePatientProfile(
    UpdatePatientProfileEvent event,
    Emitter<PatientProfileState> emit,
  ) async {
    final currentState = state;
    if (currentState is! PatientProfileLoadedState) return;

    emit(PatientProfileUpdatingState(
      patient: currentState.patient,
      pickedImage: currentState.pickedImage,
    ));

    try {
      final updatedPatient = await repository.updatePatientProfile(
        name: event.name,
        phoneNumber: event.phoneNumber,
        imageFile: event.imageFile,
        existingImageUrl: currentState.patient.profileImage,
      );
      emit(PatientProfileUpdateSuccessState(patient: updatedPatient));
    } catch (e) {
      emit(PatientProfileErrorState(e.toString()));
      // Return back to loaded state so user can retry
      emit(currentState);
    }
  }
}
