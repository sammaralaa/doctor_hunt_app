import 'package:doctor_hunt_app/features/admin/doctor_availability/data/model/doctor_availability_model.dart';

class DoctorModel {
  final String? id;
  final String name;
  final String profileImageUrl;
  final String specialty;
  final bool isActive;
  final String createdBy;
  final num consultationFee;
  final DoctorAvailabilityModel? availability;

  DoctorModel({
    required this.name,
    required this.profileImageUrl,
    required this.specialty,
    required this.isActive,
    this.id,
    required this.createdBy,
    this.consultationFee = 0,
    this.availability,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'specialty': specialty,
      'profileImageUrl': profileImageUrl,
      'isActive': isActive,
      'createdBy': createdBy,
      'consultationFee': consultationFee,
      if (availability != null) 'availability': availability!.toMap(),
      'createdAt': DateTime.now(),
    };
  }

  Map<String, dynamic> toJson() => toMap();

  factory DoctorModel.fromMap(Map<String, dynamic> map, String documentId) {
    return DoctorModel(
      id: documentId,
      name: map['name'] ?? '',
      specialty: map['specialty'] ?? '',
      profileImageUrl: map['profileImageUrl'] ?? '',
      isActive: map['isActive'] ?? true,
      createdBy: map['createdBy'] ?? '',
      consultationFee: map['consultationFee'] ?? 0.0,
      availability: map['availability'] != null
          ? DoctorAvailabilityModel.fromMap(
              Map<String, dynamic>.from(map['availability'] as Map),
            )
          : null,
    );
  }

  factory DoctorModel.fromJson(
    Map<String, dynamic> json, [
    String? documentId,
  ]) {
    return DoctorModel.fromMap(json, documentId ?? json['id'] ?? '');
  }
}

