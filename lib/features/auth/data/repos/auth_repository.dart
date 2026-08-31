import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthRepository{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  // 1. Sign Up
  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // 2. Log In
  Future<UserCredential> logIn({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<String> uploadProfileImage(File imageFile) async {
    final userId = _firebaseAuth.currentUser?.uid;
    if (userId == null) throw Exception("User not logged in");

    final storageRef = _firebaseStorage
        .ref()
        .child('user_profile_images')
        .child('$userId.jpg');

    await storageRef.putFile(imageFile);

    return await storageRef.getDownloadURL();
  }
}