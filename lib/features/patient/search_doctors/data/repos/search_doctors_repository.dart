import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';

class SearchDoctorsRepository {
  final FirebaseFirestore firestore;
  List<DoctorModel>? _cachedDoctors;

  SearchDoctorsRepository({required this.firestore});

  Future<List<DoctorModel>> searchDoctors(String query) async {
    final trimmedQuery = query.trim().toLowerCase();
    if (trimmedQuery.isEmpty) return [];

    _cachedDoctors ??= await _fetchDoctorsFromFirestore();

    return _cachedDoctors!.where((doctor) {
      final nameMatches = doctor.name.toLowerCase().contains(trimmedQuery);
      final specialtyMatches =
          doctor.specialty.toLowerCase().contains(trimmedQuery);
      return nameMatches || specialtyMatches;
    }).toList();
  }

  Future<List<DoctorModel>> _fetchDoctorsFromFirestore() async {
    final snapshot = await firestore.collection('doctors').get();
    return snapshot.docs
        .map((doc) => DoctorModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  void invalidateCache() {
    _cachedDoctors = null;
  }
}
