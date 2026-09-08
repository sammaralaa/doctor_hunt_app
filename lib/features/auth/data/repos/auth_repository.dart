
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt_app/core/services/cloudinary_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CloudinaryServices _cloudinaryService = CloudinaryServices();
  
  
  
  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String userRole,
    File? profileImageFile
  }) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final String uid = userCredential.user!.uid;
    String? imageUrl;
    if (profileImageFile != null) {
      imageUrl = await _cloudinaryService.uploadImage(profileImageFile);
    }
    await _firestore.collection('users').doc(uid).set({
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
    final UserCredential credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final String? uid = credential.user?.uid;


    final DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(uid).get();

    final Map<String, dynamic>? data = userDoc.data() as Map<String, dynamic>?;
    final String? role = data?['role'] as String?;


    return role;
  }
  //with google
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.authenticate();

    if (googleUser == null) {
      throw Exception('Google Sign-In was canceled by the user.');
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.idToken,
      idToken: googleAuth.idToken,
    );

    return await _firebaseAuth.signInWithCredential(credential);
  }
 Future<String?> uploadOrUpdateProfileImage({
    required String uid,
    required File imageFile,
  }) async {
    final String? imageUrl = await _cloudinaryService.uploadImage(imageFile);

    if (imageUrl != null) {
      await _firestore.collection('users').doc(uid).set({
        'profileImage': imageUrl,
      }, SetOptions(merge: true)); 
    }

    return imageUrl;
  }

}