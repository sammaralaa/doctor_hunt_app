class PatientModel {
  final String name;
  final String? profileImage;
  final String email;
  final String role;

  const PatientModel({
    required this.name,
    this.profileImage,
    required this.email,
    required this.role,
  });

  PatientModel copyWith({
    String? name,
    String? profileImage,
    String? email,
    String? role,
  }) {
    return PatientModel(
      name: name ?? this.name,
      profileImage: profileImage ?? this.profileImage,
      email: email ?? this.email,
      role: role ?? this.role,
    );
  }

  factory PatientModel.fromMap(Map<String, dynamic> map) {
    return PatientModel(
      name: map['name'] as String? ?? 'User',
      profileImage: map['profileImage'] as String?,
      email: map['email'] as String? ?? '',
      role: map['role'] as String? ?? 'patient',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profileImage': profileImage ?? '',
      'email': email,
      'role': role,
    };
  }
}
