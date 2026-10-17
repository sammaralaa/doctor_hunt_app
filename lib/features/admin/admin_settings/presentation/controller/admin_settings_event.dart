import 'package:equatable/equatable.dart';

abstract class AdminSettingsEvent extends Equatable {
  const AdminSettingsEvent();

  @override
  List<Object?> get props => [];
}

class LoadAdminSettingsEvent extends AdminSettingsEvent {
  const LoadAdminSettingsEvent();
}

class AdminLogoutEvent extends AdminSettingsEvent {
  const AdminLogoutEvent();
}
