import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt_app/core/utils/app_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  SplashBloc({FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
      super(SplashInitial()) {
    on<CheckInitialRouteEvent>(_onCheckInitialRoute);
  }

  // get SharedPreferences => null;

  Future<void> _onCheckInitialRoute(
    CheckInitialRouteEvent event,
    Emitter<SplashState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    final bool isFirstTime = prefs.getBool(AppConstants.isFirstTime) ?? true;

    if (isFirstTime) {
      emit(NavigateToOnboarding());
      return;
    }

    final currentUser = _firebaseAuth.currentUser;

    if (currentUser != null) {
      final docSnapshot = await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .get();
      if (docSnapshot.exists && docSnapshot.data() != null) {
        String userRole = docSnapshot.data()!['role'];
        if (userRole == 'admin') {
          emit(NavigateToAdminHome());
        } else {
          emit(NavigateToPatientHome());
        }
      }
      
    } else {
      emit(NavigateToLogin());
    }
  }
}
