class DoctorModel {
  final String? id;
  final String name;
  final String profileImageUrl;
  final String specialty;
  final bool isActive;
  final String createdBy;
  final num consultationFee;

  DoctorModel({
    required this.name,
    required this.profileImageUrl,
    required this.specialty,
    required this.isActive,
    this.id,
    required this.createdBy,
    this.consultationFee = 0,
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
    );
  }

  factory DoctorModel.fromJson(
    Map<String, dynamic> json, [
    String? documentId,
  ]) {
    return DoctorModel.fromMap(json, documentId ?? json['id'] ?? '');
  }
}
