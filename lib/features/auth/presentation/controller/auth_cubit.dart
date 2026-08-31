import 'dart:io';
import 'package:doctor_hunt_app/features/auth/data/repos/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(AuthInitial());

  // Sign Up Logic
  void emitSignUp({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      final userCredential = await _authRepository.signUp(
        email: email,
        password: password,
      );
      emit(AuthSuccess(userCredential.user!));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? "An error occurred during sign up"));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  // Log In Logic
  void emitLogIn({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      final userCredential = await _authRepository.logIn(
        email: email,
        password: password,
      );
      emit(AuthSuccess(userCredential.user!));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? "An error occurred during log in"));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  // Upload Profile Image Logic
  void emitUploadProfileImage(File imageFile) async {
    emit(AuthLoading());
    try {
      final imageUrl = await _authRepository.uploadProfileImage(imageFile);
      emit(ImageUploadSuccess(imageUrl));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}