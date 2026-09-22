import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';

class DoctorsListRepository {
  final FirebaseFirestore _firestore;

  DoctorsListRepository({required this._firestore});

  // Future<List<DoctorModel>> getDoctors() async {
  //   try {
  //     final querySnapshot = await _firestore
  //         .collection('doctors')
  //         .orderBy('createdAt', descending: true)
  //         .get();

  //     return querySnapshot.docs.map((doc) {
  //       return DoctorModel.fromMap(doc.data(), doc.id);
  //     }).toList();
  //   } catch (e) {
  //     throw Exception('Faild to get doctor\'s data ${e.toString()}');
  //   }
  // }
  Stream<List<DoctorModel>> getDoctors() {
  return _firestore
      .collection('doctors')
      .snapshots() 
      .map((snapshot) {
    return snapshot.docs.map((doc) {
      return DoctorModel.fromMap(doc.data(), doc.id);
    }).toList();
  });
}
}
