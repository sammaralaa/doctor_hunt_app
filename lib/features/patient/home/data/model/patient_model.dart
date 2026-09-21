// user_profile_model.dart
class PatientModel {
  final String name;
  final String? profileImage;

  PatientModel({
    required this.name,
    this.profileImage,
  });

  PatientModel copyWith({
    String? name,
    String? profileImage,
  }) {
    return PatientModel(
      name: name ?? this.name,
      profileImage: profileImage ?? this.profileImage,
    );
  }
  
  factory PatientModel.fromMap(Map<String, dynamic> map) {
    return PatientModel(
      name: map['name'] ?? map['displayName'] ?? 'User',
      profileImage: map['profileImage'],
    );
  }
}