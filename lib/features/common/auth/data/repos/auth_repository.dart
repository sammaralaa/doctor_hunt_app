import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt_app/core/services/cloudinary_services.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FirebaseFirestore _firestore;
  final CloudinaryServices _cloudinaryService;

  AuthRepository({
    required this._firebaseAuth,
    required this._googleSignIn,
    required this._firestore,
    required this._cloudinaryService,
  });
  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String name,
    required String userRole,
    File? profileImageFile,
  }) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final User? user = userCredential.user;
    if (user == null) {
      throw Exception(t.signUpFailed);
    }
    await user.updateDisplayName(name);
    String? imageUrl;
    if (profileImageFile != null) {
      imageUrl = await _cloudinaryService.uploadImage(profileImageFile);
    }
    await _firestore.collection('users').doc(user.uid).set({
      'name': name,
      'email': email,
      'role': userRole,
      'profileImage': imageUrl ?? '',
    });
    return userCredential;
  }

  // 2. Log In
  Future<String?> logIn({
    required String email,
    required String password,
  }) async {
    final UserCredential credential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);

    final String? uid = credential.user?.uid;

    final DocumentSnapshot userDoc = await _firestore
        .collection('users')
        .doc(uid)
        .get();

    final Map<String, dynamic>? data = userDoc.data() as Map<String, dynamic>?;
    final String? role = data?['role'] as String?;

    return role;
  }


  Future<UserCredential> signInWithGoogle({
    String defaultRole = 'patient',
  }) async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.authenticate();

    if (googleUser == null) {
      throw Exception('Google Sign-In was canceled by the user.');
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.idToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    final User? user = userCredential.user;

    if (user != null) {
      final userDoc = await _firestore.collection('users').doc(user.uid).get();

      if (!userDoc.exists) {
        await _firestore.collection('users').doc(user.uid).set({
          'name': user.displayName ?? '',
          'email': user.email ?? '',
          'role': defaultRole,
          'profileImage': user.photoURL ?? '',
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    }

    return userCredential;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
    // print('User signed out successfully. ${_firebaseAuth.currentUser}');
  }
}
