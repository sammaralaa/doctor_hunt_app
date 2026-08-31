
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

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