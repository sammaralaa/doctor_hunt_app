class DoctorModel {
  final String? id;
  final String name;
  final String profileImageUrl;
  final String specialty;
  final bool isActive;
  final String createdBy;

  DoctorModel({
    required this.name,
    required this.profileImageUrl,
    required this.specialty,
    required this.isActive,
    this.id, required this.createdBy,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'specialty': specialty,
      'imageUrl': profileImageUrl,
      'isActive': isActive,
      'createdBy': createdBy,
      'createdAt': DateTime.now(),
    };
  }
  factory DoctorModel.fromMap(Map<String, dynamic> map, String documentId) {
    return DoctorModel(
      id: documentId,
      name: map['name'] ?? '',
      specialty: map['specialty'] ?? '',
      profileImageUrl: map['profileImageUrl'] ?? map['imageUrl'],
      isActive: map['isActive'] ?? true,
      createdBy: map['createdBy']
    );
  }
}
