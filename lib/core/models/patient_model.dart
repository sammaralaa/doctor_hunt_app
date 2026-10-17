import 'package:equatable/equatable.dart';

class PatientModel extends Equatable {
  final String? uid;
  final String name;
  final String? profileImage;
  final String email;
  final String role;
  final String? phoneNumber;

  const PatientModel({
    this.uid,
    required this.name,
    this.profileImage,
    required this.email,
    required this.role,
    this.phoneNumber,
  });

  PatientModel copyWith({
    String? uid,
    String? name,
    String? profileImage,
    String? email,
    String? role,
    String? phoneNumber,
  }) {
    return PatientModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      profileImage: profileImage ?? this.profileImage,
      email: email ?? this.email,
      role: role ?? this.role,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  factory PatientModel.fromMap(Map<String, dynamic> map, [String? uid]) {
    return PatientModel(
      uid: uid ?? map['uid'] as String?,
      name: map['name'] as String? ?? 'User',
      profileImage: map['profileImage'] as String?,
      email: map['email'] as String? ?? '',
      role: map['role'] as String? ?? 'patient',
      phoneNumber: map['phoneNumber'] as String?,
    );
  }

  factory PatientModel.fromJson(Map<String, dynamic> json, [String? uid]) =>
      PatientModel.fromMap(json, uid);

  Map<String, dynamic> toMap() {
    return {
      if (uid != null) 'uid': uid,
      'name': name,
      'profileImage': profileImage ?? '',
      'email': email,
      'role': role,
      'phoneNumber': phoneNumber ?? '',
    };
  }

  Map<String, dynamic> toJson() => toMap();

  @override
  List<Object?> get props => [uid, name, profileImage, email, role, phoneNumber];
}
