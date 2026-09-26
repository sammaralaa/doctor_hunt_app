
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';


class DoctorDetailsRepository {
  
  final FirebaseFirestore _firestore;
  DoctorDetailsRepository({
    required this._firestore,
  });

 Future<DoctorModel> getDoctorById(String doctorId) async {
    final docSnapshot = await _firestore
        .collection('doctors')
        .doc(doctorId)
        .get();

    if (!docSnapshot.exists || docSnapshot.data() == null) {
      throw Exception(t.doctorNotFound);
    }

    return DoctorModel.fromMap(docSnapshot.data()!, docSnapshot.id);
  }
}
