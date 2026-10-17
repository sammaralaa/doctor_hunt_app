import 'package:equatable/equatable.dart';

class PatientProfileModel extends Equatable {
  final String uid;
  final String name;
  final String email;
  final String profileImage;

  const PatientProfileModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.profileImage,
  });

  factory PatientProfileModel.fromMap(Map<String, dynamic> data, String uid) {
    return PatientProfileModel(
      uid: uid,
      name: data['name'] as String? ?? '',
      email: data['email'] as String? ?? '',
      profileImage: data['profileImage'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'profileImage': profileImage,
      'role': 'patient',
    };
  }

  PatientProfileModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? profileImage,
  }) {
    return PatientProfileModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
    );
  }

  @override
  List<Object?> get props => [uid, name, email, profileImage];
}
