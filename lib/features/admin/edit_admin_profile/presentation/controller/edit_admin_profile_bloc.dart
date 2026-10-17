import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_hunt_app/features/admin/edit_admin_profile/data/repos/edit_admin_profile_repository.dart';
import 'package:doctor_hunt_app/features/admin/edit_admin_profile/presentation/controller/edit_admin_profile_event.dart';
import 'package:doctor_hunt_app/features/admin/edit_admin_profile/presentation/controller/edit_admin_profile_state.dart';

class EditAdminProfileBloc
    extends Bloc<EditAdminProfileEvent, EditAdminProfileState> {
  final EditAdminProfileRepository repository;

  EditAdminProfileBloc({required this.repository})
      : super(const EditAdminProfileInitialState()) {
    on<LoadAdminProfileEvent>(_onLoadAdminProfile);
    on<PickProfileImageEvent>(_onPickProfileImage);
    on<UpdateAdminProfileEvent>(_onUpdateAdminProfile);
  }

  Future<void> _onLoadAdminProfile(
    LoadAdminProfileEvent event,
    Emitter<EditAdminProfileState> emit,
  ) async {
    emit(const EditAdminProfileLoadingState());
    try {
      final profile = await repository.fetchAdminProfile();
      emit(EditAdminProfileLoadedState(adminProfile: profile));
    } catch (e) {
      emit(EditAdminProfileErrorState(e.toString()));
    }
  }

  void _onPickProfileImage(
    PickProfileImageEvent event,
    Emitter<EditAdminProfileState> emit,
  ) {
    final currentState = state;
    if (currentState is EditAdminProfileLoadedState) {
      emit(currentState.copyWith(
        pickedImage: () => event.imageFile,
      ));
    }
  }

  Future<void> _onUpdateAdminProfile(
    UpdateAdminProfileEvent event,
    Emitter<EditAdminProfileState> emit,
  ) async {
    final currentState = state;
    if (currentState is! EditAdminProfileLoadedState) return;

    emit(currentState.copyWith(
      isSaving: true,
      saveSuccess: false,
      errorMessage: () => null,
    ));

    try {
      final updatedProfile = await repository.updateAdminProfile(
        name: event.name,
        clinicLocation: event.clinicLocation,
        imageFile: event.imageFile ?? currentState.pickedImage,
        existingImageUrl: currentState.adminProfile.profileImage,
      );

      emit(currentState.copyWith(
        adminProfile: updatedProfile,
        isSaving: false,
        saveSuccess: true,
        errorMessage: () => null,
      ));
    } catch (e) {
      emit(currentState.copyWith(
        isSaving: false,
        saveSuccess: false,
        errorMessage: () => e.toString(),
      ));
    }
  }
}
