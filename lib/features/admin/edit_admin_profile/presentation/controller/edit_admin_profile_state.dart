import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:doctor_hunt_app/features/admin/edit_admin_profile/data/model/admin_profile_model.dart';

abstract class EditAdminProfileState extends Equatable {
  const EditAdminProfileState();

  @override
  List<Object?> get props => [];
}

class EditAdminProfileInitialState extends EditAdminProfileState {
  const EditAdminProfileInitialState();
}

class EditAdminProfileLoadingState extends EditAdminProfileState {
  const EditAdminProfileLoadingState();
}

class EditAdminProfileLoadedState extends EditAdminProfileState {
  final AdminProfileModel adminProfile;
  final File? pickedImage;
  final bool isSaving;
  final bool saveSuccess;
  final String? errorMessage;

  const EditAdminProfileLoadedState({
    required this.adminProfile,
    this.pickedImage,
    this.isSaving = false,
    this.saveSuccess = false,
    this.errorMessage,
  });

  EditAdminProfileLoadedState copyWith({
    AdminProfileModel? adminProfile,
    File? Function()? pickedImage,
    bool? isSaving,
    bool? saveSuccess,
    String? Function()? errorMessage,
  }) {
    return EditAdminProfileLoadedState(
      adminProfile: adminProfile ?? this.adminProfile,
      pickedImage:
          pickedImage != null ? pickedImage() : this.pickedImage,
      isSaving: isSaving ?? this.isSaving,
      saveSuccess: saveSuccess ?? this.saveSuccess,
      errorMessage:
          errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        adminProfile,
        pickedImage?.path,
        isSaving,
        saveSuccess,
        errorMessage,
      ];
}

class EditAdminProfileErrorState extends EditAdminProfileState {
  final String errorMessage;

  const EditAdminProfileErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
