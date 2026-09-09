import 'package:doctor_hunt_app/features/common/auth/data/repos/auth_repository.dart';
import 'package:doctor_hunt_app/features/common/auth/presentation/controller/auth_events.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<SignUpRequestedEvent>(_onSignUpRequested);
    on<LogInRequestedEvent>(_onLogInRequested);
    on<SignOutRequestedEvent>(_onSignOutRequested);
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
        userRole: event.userRole,
      );

      if (userCredential.user != null && event.name.isNotEmpty) {
        await userCredential.user!.updateDisplayName(event.name);
      }

      emit(AuthSuccess(role: event.userRole ));
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
       final String? role = await authRepository.logIn(
        email: event.email,
        password: event.password,
      );

      emit(AuthSuccess(role: role ?? 'patient'));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(_mapFirebaseAuthError(e)));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
  Future<void> _onSignOutRequested(
    SignOutRequestedEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      await authRepository.signOut();
      //print(authRepository.)
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
  String _mapFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return t.EmailAddressAlreadyInUse;
      case 'invalid-email':
        return t.EmailAddressNotValid;
      case 'weak-password':
        return t.thePasswordisWeak;
      case 'operation-not-allowed':
        return t.AccountsAreNotEnabled;
      default:
        return e.message ?? t.anUnknownAuthError;
    }
  }
}
