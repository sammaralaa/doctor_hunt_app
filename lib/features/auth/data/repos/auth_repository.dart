
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt_app/core/utils/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 1. Sign Up
  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String userRole,
  }) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final String uid = userCredential.user!.uid;
    await _firestore.collection('users').doc(uid).set({
      'role': userRole,
      //'createdAt': FieldValue.serverTimestamp(),
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
    if (uid == null) return null;

    final DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(uid).get();

    final Map<String, dynamic>? data = userDoc.data() as Map<String, dynamic>?;
    final String? role = data?['role'] as String?;

    // if (role != null) {
    //   final prefs = await SharedPreferences.getInstance();
    //   await prefs.setString(AppConstants.userRole, role);
    // }

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
  // Future<String> uploadProfileImage(File imageFile) async {
  //   final userId = _firebaseAuth.currentUser?.uid;
  //   if (userId == null) throw Exception("User not logged in");

  //   final storageRef = _firebaseStorage
  //       .ref()
  //       .child('user_profile_images')
  //       .child('$userId.jpg');

  //   await storageRef.putFile(imageFile);

  //   return await storageRef.getDownloadURL();
  // }
}