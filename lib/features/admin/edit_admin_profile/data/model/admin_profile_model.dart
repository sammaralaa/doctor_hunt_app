import 'package:equatable/equatable.dart';

class AdminProfileModel extends Equatable {
  final String uid;
  final String name;
  final String email;
  final String clinicLocation;
  final String profileImage;

  const AdminProfileModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.clinicLocation,
    required this.profileImage,
  });

  factory AdminProfileModel.fromMap(Map<String, dynamic> data, String uid) {
    return AdminProfileModel(
      uid: uid,
      name: data['name'] as String? ?? '',
      email: data['email'] as String? ?? '',
      clinicLocation:
          data['clinicLocation'] as String? ?? 'DoctorHunt HQ Clinic',
      profileImage: data['profileImage'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'clinicLocation': clinicLocation,
      'profileImage': profileImage,
      'role': 'admin',
    };
  }

  AdminProfileModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? clinicLocation,
    String? profileImage,
  }) {
    return AdminProfileModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      clinicLocation: clinicLocation ?? this.clinicLocation,
      profileImage: profileImage ?? this.profileImage,
    );
  }

  @override
  List<Object?> get props => [uid, name, email, clinicLocation, profileImage];
}
