import 'package:doctor_hunt_app/core/models/appointment_model.dart';
import 'package:doctor_hunt_app/features/common/appointment_details/data/repos/appointment_details_repository.dart';
import 'package:doctor_hunt_app/features/common/appointment_details/presentation/controller/appointment_details_bloc.dart';
import 'package:doctor_hunt_app/features/common/appointment_details/presentation/controller/appointment_details_event.dart';
import 'package:doctor_hunt_app/features/common/appointment_details/presentation/controller/appointment_details_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAppointmentDetailsRepository extends Mock
    implements AppointmentDetailsRepository {}

void main() {
  late MockAppointmentDetailsRepository mockRepository;
  late AppointmentDetailsBloc bloc;

  setUp(() {
    mockRepository = MockAppointmentDetailsRepository();
    bloc = AppointmentDetailsBloc(repository: mockRepository);
  });

  tearDown(() {
    bloc.close();
  });

  const testAppointment = AppointmentModel(
    id: 'app-123',
    doctorId: 'doc-1',
    doctorName: 'Dr. Ahmed Ali',
    doctorSpecialty: 'Cardiologist',
    patientId: 'patient-1',
    patientName: 'Maya Patel',
    patientEmail: 'maya.patel@example.com',
    date: '02 Oct 2026',
    time: '10:30 AM',
    fee: 28,
    status: 'Upcoming',
    clinicLocation: 'Central Clinic • 24 Garden Avenue',
  );

  test('initial state is AppointmentDetailsInitialState', () {
    expect(bloc.state, const AppointmentDetailsInitialState());
  });

  test('FetchAppointmentDetailsEvent emits Loaded state on success', () async {
    when(() => mockRepository.getAppointmentById('app-123'))
        .thenAnswer((_) async => testAppointment);

    bloc.add(const FetchAppointmentDetailsEvent('app-123'));

    await expectLater(
      bloc.stream,
      emitsInOrder([
        const AppointmentDetailsLoadingState(),
        predicate<AppointmentDetailsLoadedState>((state) {
          expect(state.appointment.id, 'app-123');
          expect(state.appointment.doctorName, 'Dr. Ahmed Ali');
          expect(state.appointment.patientName, 'Maya Patel');
          expect(state.appointment.status, 'Upcoming');
          return true;
        }),
      ]),
    );

    verify(() => mockRepository.getAppointmentById('app-123')).called(1);
  });

  test('FetchAppointmentDetailsEvent emits Error state on failure', () async {
    when(() => mockRepository.getAppointmentById('app-123'))
        .thenThrow(Exception('Appointment not found'));

    bloc.add(const FetchAppointmentDetailsEvent('app-123'));

    await expectLater(
      bloc.stream,
      emitsInOrder([
        const AppointmentDetailsLoadingState(),
        predicate<AppointmentDetailsErrorState>((state) {
          expect(state.errorMessage, contains('Appointment not found'));
          return true;
        }),
      ]),
    );

    verify(() => mockRepository.getAppointmentById('app-123')).called(1);
  });

  test(
      'CancelAppointmentDetailEvent updates status to Cancelled and sets success message',
      () async {
    when(() => mockRepository.getAppointmentById('app-123'))
        .thenAnswer((_) async => testAppointment);
    when(() => mockRepository.cancelAppointment(appointmentId: 'app-123'))
        .thenAnswer((_) async {});

    bloc.add(const FetchAppointmentDetailsEvent('app-123'));
    await bloc.stream.firstWhere((s) => s is AppointmentDetailsLoadedState);

    bloc.add(const CancelAppointmentDetailEvent('app-123'));

    await expectLater(
      bloc.stream,
      emitsInOrder([
        predicate<AppointmentDetailsLoadedState>((state) {
          expect(state.isProcessing, isTrue);
          return true;
        }),
        predicate<AppointmentDetailsLoadedState>((state) {
          expect(state.isProcessing, isFalse);
          expect(state.appointment.status, 'Cancelled');
          expect(state.successMessage, isNotNull);
          return true;
        }),
      ]),
    );

    verify(() => mockRepository.cancelAppointment(appointmentId: 'app-123'))
        .called(1);
  });

  test(
      'MarkAppointmentCompletedDetailEvent updates status to Completed and sets success message',
      () async {
    when(() => mockRepository.getAppointmentById('app-123'))
        .thenAnswer((_) async => testAppointment);
    when(() =>
            mockRepository.markAppointmentCompleted(appointmentId: 'app-123'))
        .thenAnswer((_) async {});

    bloc.add(const FetchAppointmentDetailsEvent('app-123'));
    await bloc.stream.firstWhere((s) => s is AppointmentDetailsLoadedState);

    bloc.add(const MarkAppointmentCompletedDetailEvent('app-123'));

    await expectLater(
      bloc.stream,
      emitsInOrder([
        predicate<AppointmentDetailsLoadedState>((state) {
          expect(state.isProcessing, isTrue);
          return true;
        }),
        predicate<AppointmentDetailsLoadedState>((state) {
          expect(state.isProcessing, isFalse);
          expect(state.appointment.status, 'Completed');
          expect(state.successMessage, isNotNull);
          return true;
        }),
      ]),
    );

    verify(() =>
            mockRepository.markAppointmentCompleted(appointmentId: 'app-123'))
        .called(1);
  });
}
