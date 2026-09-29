import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Doctor Model Tests", () {
    test('fromMap should return a valid DoctorModel', () {
      // Arrange
      final Map<String, dynamic> jsonMap = {
        'name': 'Dr. Ahmed',
        'specialty': 'Cardiology',
        'profileImageUrl': 'https://example.com/image.png',
        'isActive': true,
        'createdBy': 'admin_1',
      };
      const documentId = 'doc_123';

      // Act
      final result = DoctorModel.fromMap(jsonMap, documentId);

      // Assert
      expect(result.id, documentId);
      expect(result.name, jsonMap['name']);
      expect(result.specialty, jsonMap['specialty']);
      expect(result.profileImageUrl, jsonMap['profileImageUrl']);
    });

    test('toMap should return a JSON map containing the proper data', () {
      final tDoctorModel = DoctorModel(
        id: 'doc_123',
        name: 'Dr. Ahmed',
        profileImageUrl: 'https://example.com/image.png',
        specialty: 'Cardiology',
        isActive: true,
        createdBy: 'admin_1',
      );

      // Act
      final result = tDoctorModel.toMap();

      // Assert
      expect(result['id'], tDoctorModel.id);
      expect(result['name'], tDoctorModel.name);
      expect(result['specialty'], tDoctorModel.specialty);
      expect(result['profileImageUrl'], tDoctorModel.profileImageUrl);
      expect(result['isActive'], tDoctorModel.isActive);
      expect(result['createdBy'], tDoctorModel.createdBy);
      expect(result['createdAt'], isA<DateTime>());
    });
  });
}
