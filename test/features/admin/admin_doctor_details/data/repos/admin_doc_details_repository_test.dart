import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt_app/features/admin/admin_doctor_details/data/repos/admin_doc_details_repository.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockDocumentSnapshot extends Mock
    implements DocumentSnapshot<Map<String, dynamic>> {}

void main() {
  late AdminDocDetailsRepository repository;
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference mockCollection;
  late MockDocumentReference mockDocRef;
  late MockDocumentSnapshot mockDocSnapshot;

  const String tDoctorId = 'doc_123';

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockCollection = MockCollectionReference();
    mockDocRef = MockDocumentReference();
    mockDocSnapshot = MockDocumentSnapshot();

    repository = AdminDocDetailsRepository(firestore: mockFirestore);

    // Default Firestore routing setup
    when(() => mockFirestore.collection('doctors')).thenReturn(mockCollection);
    when(() => mockCollection.doc(tDoctorId)).thenReturn(mockDocRef);
  });

  group('getDoctorById', () {

    final Map<String, dynamic> tDoctorData = {
      'name': 'Dr. John Doe',
      'specialty': 'Cardiologist',
      'profileImageUrl': 'https://example.com/avatar.png',
      'isActive': true,
      'createdBy': 'admin_1',
    };

    test('should return DoctorModel when document exists', () async {
      // Arrange
      when(() => mockDocRef.get()).thenAnswer((_) async => mockDocSnapshot);
      when(() => mockDocSnapshot.exists).thenReturn(true);
      when(() => mockDocSnapshot.data()).thenReturn(tDoctorData);
      when(() => mockDocSnapshot.id).thenReturn(tDoctorId);

      // Act
      final result = await repository.getDoctorById(tDoctorId);

      // Assert
      expect(result, isA<DoctorModel>());
      verify(() => mockDocRef.get()).called(1);
    });

    test('should throw Exception when document does not exist', () async {
      // Arrange
      when(() => mockDocRef.get()).thenAnswer((_) async => mockDocSnapshot);
      when(() => mockDocSnapshot.exists).thenReturn(false);

      // Act & Assert
      expect(
        () => repository.getDoctorById(tDoctorId),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Doctor not found'),
          ),
        ),
      );
    });
  });

  group("updateDoctorStatus", () {
    const bool tIsActive = false;
    test('should complete successfully when update succeeds', () async {
      // Arrange
      when(
        () => mockDocRef.update({'isActive': tIsActive}),
      ).thenAnswer((_) async => {});

      // Act
      await repository.updateDoctorStatus(
        doctorId: tDoctorId,
        isActive: tIsActive,
      );

      // Assert
      verify(() => mockDocRef.update({'isActive': tIsActive})).called(1);
    });
    test('should throw Exception when update fails', () async {
      // Arrange
      when(
        () => mockDocRef.update(any()),
      ).thenThrow(FirebaseException(plugin: 'firestore'));

      // Act & Assert
      expect(
        () => repository.updateDoctorStatus(
          doctorId: tDoctorId,
          isActive: tIsActive,
        ),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Failed to update doctor status'),
          ),
        ),
      );
    });
  });

  group("deleteDoctor", () {
    test("should complete successfully when deletion succeeds", () async {
      when(() => mockDocRef.delete()).thenAnswer((_) async => {});

      await repository.deleteDoctor(tDoctorId);

      verify(() => mockDocRef.delete()).called(1);
    });

    test('should throw Exception when deletion fails', () async {
      // Arrange
      when(() => mockDocRef.delete()).thenThrow(FirebaseException(plugin: 'firestore'));

      // Act & Assert
      expect(
        () => repository.deleteDoctor(tDoctorId),
        throwsA(isA<Exception>().having((e) => e.toString(), 'message', contains('Failed to Delete Doctor'))),
      );
    });
  });
}
