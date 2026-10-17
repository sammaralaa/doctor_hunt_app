import 'dart:async';
import 'package:doctor_hunt_app/core/models/appointment_model.dart';
import 'package:doctor_hunt_app/features/patient/patient_appointments/data/repos/patient_appointments_repository.dart';
import 'package:doctor_hunt_app/features/patient/patient_appointments/presentation/controller/patient_appointments_bloc.dart';
import 'package:doctor_hunt_app/features/patient/patient_appointments/presentation/controller/patient_appointments_event.dart';
import 'package:doctor_hunt_app/features/patient/patient_appointments/presentation/controller/patient_appointments_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPatientAppointmentsRepository extends Mock
    implements PatientAppointmentsRepository {}

void main() {
  late MockPatientAppointmentsRepository mockRepository;
  late PatientAppointmentsBloc bloc;

  setUp(() {
    mockRepository = MockPatientAppointmentsRepository();
    bloc = PatientAppointmentsBloc(repository: mockRepository);
  });

  tearDown(() {
    bloc.close();
  });

  const testAppointments = [
    AppointmentModel(
      id: 'app-1',
      doctorId: 'doc-1',
      doctorName: 'Dr. Ananya Shah',
      doctorSpecialty: 'Specialist Cardiologist',
      patientId: 'patient-1',
      patientName: 'John',
      date: '02 Oct 2026',
      time: '10:30 AM',
      fee: 28,
      status: 'Upcoming',
    ),
    AppointmentModel(
      id: 'app-2',
      doctorId: 'doc-2',
      doctorName: 'Dr. Sarah Tranquilli',
      doctorSpecialty: 'Specialist Medicine',
      patientId: 'patient-1',
      patientName: 'John',
      date: '21 Sep 2026',
      time: '09:00 AM',
      fee: 30,
      status: 'Completed',
      rating: 5,
    ),
    AppointmentModel(
      id: 'app-3',
      doctorId: 'doc-3',
      doctorName: 'Dr. Luke Whitesell',
      doctorSpecialty: 'Specialist Cardiology',
      patientId: 'patient-1',
      patientName: 'John',
      date: '30 Aug 2026',
      time: '11:00 AM',
      fee: 35,
      status: 'Cancelled',
    ),
  ];

  test('initial state is PatientAppointmentsInitialState', () {
    expect(bloc.state, const PatientAppointmentsInitialState());
  });

  test(
      'FetchPatientAppointmentsEvent categorizes appointments and updates in real-time as stream emits new data',
      () async {
    final controller = StreamController<List<AppointmentModel>>();
    when(() => mockRepository.fetchMyAppointments())
        .thenAnswer((_) => controller.stream);

    bloc.add(const FetchPatientAppointmentsEvent());

    // Push initial list
    controller.add(testAppointments);

    await expectLater(
      bloc.stream,
      emitsInOrder([
        const PatientAppointmentsLoadingState(),
        predicate<PatientAppointmentsLoadedState>((state) {
          expect(state.upcomingAppointments.length, 1);
          expect(state.upcomingAppointments.first.id, 'app-1');

          expect(state.completedAppointments.length, 1);
          expect(state.completedAppointments.first.id, 'app-2');

          expect(state.cancelledAppointments.length, 1);
          expect(state.cancelledAppointments.first.id, 'app-3');

          return true;
        }),
      ]),
    );

    // Push updated data into the stream
    final updatedAppointments = [
      ...testAppointments,
      const AppointmentModel(
        id: 'app-4',
        doctorId: 'doc-4',
        doctorName: 'Dr. New Doctor',
        doctorSpecialty: 'Dentist',
        patientId: 'patient-1',
        patientName: 'John',
        date: '05 Oct 2026',
        time: '02:00 PM',
        fee: 50,
        status: 'Upcoming',
      ),
    ];
    controller.add(updatedAppointments);

    await expectLater(
      bloc.stream,
      emits(
        predicate<PatientAppointmentsLoadedState>((state) {
          expect(state.upcomingAppointments.length, 2);
          expect(state.upcomingAppointments.last.id, 'app-4');
          return true;
        }),
      ),
    );

    await controller.close();
    verify(() => mockRepository.fetchMyAppointments()).called(1);
  });

  test('FetchPatientAppointmentsEvent emits error state on failure', () async {
    when(() => mockRepository.fetchMyAppointments())
        .thenAnswer((_) => Stream.error(Exception('Firestore network error')));

    bloc.add(const FetchPatientAppointmentsEvent());

    await expectLater(
      bloc.stream,
      emitsInOrder([
        const PatientAppointmentsLoadingState(),
        predicate<PatientAppointmentsErrorState>((state) {
          expect(state.errorMessage, contains('Firestore network error'));
          return true;
        }),
      ]),
    );

    verify(() => mockRepository.fetchMyAppointments()).called(1);
  });

  group('CancelAppointmentEvent', () {
    test(
        'successfully cancels appointment, updates local state, and marks cancelSuccess',
        () async {
      when(() => mockRepository.fetchMyAppointments())
          .thenAnswer((_) => Stream.value(testAppointments));
      when(() => mockRepository.cancelAppointment(appointmentId: 'app-1'))
          .thenAnswer((_) async {});

      bloc.add(const FetchPatientAppointmentsEvent());
      await bloc.stream.firstWhere((s) => s is PatientAppointmentsLoadedState);

      bloc.add(const CancelAppointmentEvent('app-1'));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          predicate<PatientAppointmentsLoadedState>((state) {
            expect(state.cancellingAppointmentId, 'app-1');
            expect(state.cancelSuccess, false);
            return true;
          }),
          predicate<PatientAppointmentsLoadedState>((state) {
            expect(state.cancellingAppointmentId, isNull);
            expect(state.cancelSuccess, true);
            expect(state.upcomingAppointments.any((a) => a.id == 'app-1'), isFalse);
            expect(state.cancelledAppointments.any((a) => a.id == 'app-1'), isTrue);
            final cancelledApp =
                state.cancelledAppointments.firstWhere((a) => a.id == 'app-1');
            expect(cancelledApp.status, 'Cancelled');
            return true;
          }),
        ]),
      );

      verify(() => mockRepository.cancelAppointment(appointmentId: 'app-1'))
          .called(1);
    });

    test('sets cancelErrorMessage when repository throws', () async {
      when(() => mockRepository.fetchMyAppointments())
          .thenAnswer((_) => Stream.value(testAppointments));
      when(() => mockRepository.cancelAppointment(appointmentId: 'app-1'))
          .thenThrow(Exception('Failed to cancel'));

      bloc.add(const FetchPatientAppointmentsEvent());
      await bloc.stream.firstWhere((s) => s is PatientAppointmentsLoadedState);

      bloc.add(const CancelAppointmentEvent('app-1'));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          predicate<PatientAppointmentsLoadedState>((state) {
            expect(state.cancellingAppointmentId, 'app-1');
            return true;
          }),
          predicate<PatientAppointmentsLoadedState>((state) {
            expect(state.cancellingAppointmentId, isNull);
            expect(state.cancelSuccess, false);
            expect(state.cancelErrorMessage, contains('Failed to cancel'));
            return true;
          }),
        ]),
      );

      verify(() => mockRepository.cancelAppointment(appointmentId: 'app-1'))
          .called(1);
    });
  });
}
