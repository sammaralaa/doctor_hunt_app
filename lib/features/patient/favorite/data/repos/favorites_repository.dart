import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoritesRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  FavoritesRepository({
    required this._firestore,
    required this._firebaseAuth,
  });

  String? get currentUserId => _firebaseAuth.currentUser?.uid;

  CollectionReference<Map<String, dynamic>> _userFavoritesCollection(
    String userId,
  ) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites');
  }

  Future<void> addDoctorToFavorites(DoctorModel doctor) async {
    final uid = currentUserId;
    if (uid == null) {
      throw Exception('User is not authenticated');
    }
    if (doctor.id == null || doctor.id!.isEmpty) {
      throw Exception('Doctor ID cannot be null or empty');
    }

    final docRef = _userFavoritesCollection(uid).doc(doctor.id);
    await docRef.set({
      'name': doctor.name,
      'specialty': doctor.specialty,
      'profileImageUrl': doctor.profileImageUrl,
      'isActive': doctor.isActive,
      'createdBy': doctor.createdBy,
      'doctorId': doctor.id,
      'addedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> removeDoctorFromFavorites(String doctorId) async {
    final uid = currentUserId;
    if (uid == null) {
      throw Exception('User is not authenticated');
    }

    await _userFavoritesCollection(uid).doc(doctorId).delete();
  }

  Future<bool> isDoctorFavorite(String doctorId) async {
    final uid = currentUserId;
    if (uid == null) return false;

    final doc = await _userFavoritesCollection(uid).doc(doctorId).get();
    return doc.exists;
  }

  Stream<List<DoctorModel>> getFavoriteDoctors() {
    final uid = currentUserId;
    if (uid == null) {
      return Stream.value(<DoctorModel>[]);
    }

    return _userFavoritesCollection(uid).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return DoctorModel.fromMap(data, doc.id);
      }).toList();
    });
  }

  Stream<Set<String>> getFavoriteDoctorIds() {
    final uid = currentUserId;
    if (uid == null) {
      return Stream.value(<String>{});
    }

    return _userFavoritesCollection(uid).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.id).toSet();
    });
  }
}
