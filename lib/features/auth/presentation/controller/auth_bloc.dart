import 'package:doctor_hunt_app/features/auth/data/repos/auth_repository.dart';
import 'package:doctor_hunt_app/features/auth/presentation/controller/auth_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<SignUpRequestedEvent>(_onSignUpRequested);
    on<LogInRequestedEvent>(_onLogInRequested);
  }

  Future<void> _onSignUpRequested(
    SignUpRequestedEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final userCredential = await authRepository.signUp(
        email: event.email,
        password: event.password,
      );

      if (userCredential.user != null && event.name.isNotEmpty) {
        await userCredential.user!.updateDisplayName(event.name);
      }

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(_mapFirebaseAuthError(e)));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onLogInRequested(
    LogInRequestedEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
       final userCredential = await authRepository.logIn(
        email: event.email,
        password: event.password,
      );
      if (userCredential.user != null) {
        await userCredential.user!.reload();
      }
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(_mapFirebaseAuthError(e)));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  String _mapFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'The email address is already in use by another account.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      default:
        return e.message ?? 'An unknown authentication error occurred.';
    }
  }
}
