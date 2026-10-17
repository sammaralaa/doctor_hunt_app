import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:doctor_hunt_app/core/services/shared_prefs_service.dart';
import 'package:doctor_hunt_app/features/patient/menu_drawer/data/repos/menu_drawer_repository.dart';
import 'menu_drawer_event.dart';
import 'menu_drawer_state.dart';

class MenuDrawerBloc extends Bloc<MenuDrawerEvent, MenuDrawerState> {
  final MenuDrawerRepository repository;

  MenuDrawerBloc({required this.repository})
      : super(const MenuDrawerInitialState()) {
    on<LoadMenuDrawerDataEvent>(_onLoadData);
    on<MenuLogoutEvent>(_onLogout);
  }

  Future<void> _onLoadData(
    LoadMenuDrawerDataEvent event,
    Emitter<MenuDrawerState> emit,
  ) async {
    emit(const MenuDrawerLoadingState());
    try {
      final patient = await repository.fetchPatientProfile();
      emit(MenuDrawerLoadedState(patient: patient));
    } catch (e) {
      emit(MenuDrawerErrorState(e.toString()));
    }
  }

  Future<void> _onLogout(
    MenuLogoutEvent event,
    Emitter<MenuDrawerState> emit,
  ) async {
    emit(const MenuLogoutLoadingState());
    try {
      await FirebaseAuth.instance.signOut();
      await SharedPrefsService.setIsLoggedIn(false);
      await SharedPrefsService.setUserRole('');
      emit(const MenuLogoutSuccessState());
    } catch (e) {
      emit(MenuLogoutErrorState(e.toString()));
    }
  }
}
