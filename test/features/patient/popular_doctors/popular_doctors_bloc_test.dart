import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';
import 'package:doctor_hunt_app/features/patient/popular_doctors/data/repos/popular_doctors_repository.dart';
import 'package:doctor_hunt_app/features/patient/popular_doctors/presentation/controller/popular_doctors_bloc.dart';
import 'package:doctor_hunt_app/features/patient/popular_doctors/presentation/controller/popular_doctors_event.dart';
import 'package:doctor_hunt_app/features/patient/popular_doctors/presentation/controller/popular_doctors_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPopularDoctorsRepository extends Mock
    implements PopularDoctorsRepository {}

void main() {
  late MockPopularDoctorsRepository mockRepository;
  late PopularDoctorsBloc bloc;

  setUp(() {
    mockRepository = MockPopularDoctorsRepository();
    bloc = PopularDoctorsBloc(repository: mockRepository);
  });

  tearDown(() {
    bloc.close();
  });

  final testDoctors = [
    DoctorModel(
      id: 'doc-1',
      name: 'Dr. Pediatrician',
      specialty: 'cardiology',
      profileImageUrl: 'https://example.com/doc1.jpg',
      isActive: true,
      createdBy: 'admin-1',
    ),
    DoctorModel(
      id: 'doc-2',
      name: 'Dr. Mistry Brick',
      specialty: 'dentist',
      profileImageUrl: 'https://example.com/doc2.jpg',
      isActive: true,
      createdBy: 'admin-1',
    ),
  ];

  test('initial state is PopularDoctorsInitialState', () {
    expect(bloc.state, const PopularDoctorsInitialState());
  });

  test('FetchPopularDoctorsEvent emits loading then loaded state on success',
      () async {
    when(() => mockRepository.getPopularDoctors())
        .thenAnswer((_) async => testDoctors);

    bloc.add(const FetchPopularDoctorsEvent());

    await expectLater(
      bloc.stream,
      emitsInOrder([
        const PopularDoctorsLoadingState(),
        PopularDoctorsLoadedState(testDoctors),
      ]),
    );

    verify(() => mockRepository.getPopularDoctors()).called(1);
  });

  test('FetchPopularDoctorsEvent emits loading then error state on failure',
      () async {
    when(() => mockRepository.getPopularDoctors())
        .thenThrow(Exception('Failed to fetch popular doctors'));

    bloc.add(const FetchPopularDoctorsEvent());

    await expectLater(
      bloc.stream,
      emitsInOrder([
        const PopularDoctorsLoadingState(),
        predicate<PopularDoctorsErrorState>((state) {
          expect(state.errorMessage, contains('Failed to fetch popular doctors'));
          return true;
        }),
      ]),
    );

    verify(() => mockRepository.getPopularDoctors()).called(1);
  });
}
