import 'package:equatable/equatable.dart';

abstract class AdminSettingsState extends Equatable {
  const AdminSettingsState();

  @override
  List<Object?> get props => [];
}

class AdminSettingsInitialState extends AdminSettingsState {
  const AdminSettingsInitialState();
}
