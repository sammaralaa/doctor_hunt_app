import 'package:doctor_hunt_app/features/admin/edit_admin_profile/data/model/admin_profile_model.dart';
import 'package:equatable/equatable.dart';

abstract class AdminSettingsState extends Equatable {
  const AdminSettingsState();

  @override
  List<Object?> get props => [];
}

class AdminSettingsInitialState extends AdminSettingsState {
  const AdminSettingsInitialState();
}

class AdminSettingsLoadingState extends AdminSettingsState {
  const AdminSettingsLoadingState();
}

class AdminSettingsLoadedState extends AdminSettingsState {
  final AdminProfileModel adminProfile;

  const AdminSettingsLoadedState({required this.adminProfile});

  @override
  List<Object?> get props => [adminProfile];
}

class AdminSettingsErrorState extends AdminSettingsState {
  final String errorMessage;

  const AdminSettingsErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class AdminLogoutLoadingState extends AdminSettingsState {
  const AdminLogoutLoadingState();
}

class LogoutSuccessState extends AdminSettingsState {
  const LogoutSuccessState();
}

typedef LogoutSuccess = LogoutSuccessState;

class AdminLogoutErrorState extends AdminSettingsState {
  final String errorMessage;

  const AdminLogoutErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
