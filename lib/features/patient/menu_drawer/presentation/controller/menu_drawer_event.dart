import 'package:equatable/equatable.dart';

abstract class MenuDrawerEvent extends Equatable {
  const MenuDrawerEvent();

  @override
  List<Object?> get props => [];
}

class LoadMenuDrawerDataEvent extends MenuDrawerEvent {
  const LoadMenuDrawerDataEvent();
}

class MenuLogoutEvent extends MenuDrawerEvent {
  const MenuLogoutEvent();
}
