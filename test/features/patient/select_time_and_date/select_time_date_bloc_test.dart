import 'package:doctor_hunt_app/core/models/appointment_model.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';
import 'package:doctor_hunt_app/features/admin/doctor_availability/data/model/doctor_availability_model.dart';
import 'package:doctor_hunt_app/features/patient/select_time_and_date/data/date_slot_model.dart';
import 'package:doctor_hunt_app/features/patient/select_time_and_date/data/repos/select_time_date_repository.dart';
import 'package:doctor_hunt_app/features/patient/select_time_and_date/presentation/controller/select_time_date_bloc.dart';
import 'package:doctor_hunt_app/features/patient/select_time_and_date/presentation/controller/select_time_date_event.dart';
import 'package:doctor_hunt_app/features/patient/select_time_and_date/presentation/controller/select_time_date_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSelectTimeDateRepository extends Mock
    implements SelectTimeDateRepository {}

void main() {
  late MockSelectTimeDateRepository mockRepository;
  late SelectTimeDateBloc bloc;

  setUpAll(() {
    registerFallbackValue(DateTime.now());
    registerFallbackValue(
      TimeSlotModel(dateTime: DateTime.now()),
    );
    registerFallbackValue(
      DoctorModel(
        id: '',
        name: '',
        specialty: '',
        profileImageUrl: '',
        isActive: true,
        createdBy: '',
      ),
    );
  });

  setUp(() {
    mockRepository = MockSelectTimeDateRepository();
    bloc = SelectTimeDateBloc(repository: mockRepository);
  });

  tearDown(() {
    bloc.close();
  });

  final testDoctor = DoctorModel(
    id: 'doc-123',
    name: 'Dr. Jane Doe',
    specialty: 'cardiology',
    profileImageUrl: 'https://example.com/image.jpg',
    isActive: true,
    createdBy: 'admin-1',
    availability: const DoctorAvailabilityModel(
      workingDays: [1, 2, 3, 4, 5, 6, 7], // works everyday for testing
      startTime: '09:00',
      endTime: '19:00',
      slotDuration: 60, // 9:00, 10:00, 11:00, 12:00, 13:00, 14:00, 15:00, 16:00, 17:00, 18:00
    ),
  );

  final testBookedAppointments = [
    const AppointmentModel(
      id: 'app-1',
      doctorId: 'doc-123',
      doctorName: 'Dr. Jane Doe',
      doctorSpecialty: 'cardiology',
      patientId: 'patient-1',
      patientName: 'John',
      date: '2026-10-14',
      time: '10:00 AM', // booked slot
      fee: 50,
      status: 'Upcoming',
    ),
  ];

  test('initial state is SelectTimeDateInitialState', () {
    expect(bloc.state, const SelectTimeDateInitialState());
  });

  test(
      'FetchDoctorAvailabilityEvent emits loading then loaded state with categorized slots and booked slots removed',
      () async {
    when(() => mockRepository.getDoctorById('doc-123'))
        .thenAnswer((_) async => testDoctor);
    when(() => mockRepository.getBookedAppointmentsForDate(
          doctorId: 'doc-123',
          date: any(named: 'date'),
        )).thenAnswer((_) async => testBookedAppointments);

    bloc.add(const FetchDoctorAvailabilityEvent('doc-123'));

    await expectLater(
      bloc.stream,
      emitsInOrder([
        const SelectTimeDateLoadingState(),
        predicate<SelectTimeDateLoadedState>((state) {
          // Verify doctor loaded
          expect(state.doctor.id, 'doc-123');

          // Verify 10:00 AM was removed (was booked)
          final morningFormatted =
              state.morningSlots.map((s) => s.formattedTime).toList();
          expect(morningFormatted.contains('10:00 AM'), isFalse);
          expect(morningFormatted.contains('9:00 AM'), isTrue);
          expect(morningFormatted.contains('11:00 AM'), isTrue);

          // Verify categorized into morning, afternoon, evening
          // Morning: 9:00 AM, 11:00 AM
          expect(state.morningSlots.length, 2);
          // Afternoon: 12:00 PM, 1:00 PM, 2:00 PM, 3:00 PM, 4:00 PM
          expect(state.afternoonSlots.length, 5);
          // Evening: 5:00 PM, 6:00 PM
          expect(state.eveningSlots.length, 2);

          return true;
        }),
      ]),
    );
  });

  test('SelectTimeSlotEvent updates selectedTimeSlot in state', () async {
    when(() => mockRepository.getDoctorById('doc-123'))
        .thenAnswer((_) async => testDoctor);
    when(() => mockRepository.getBookedAppointmentsForDate(
          doctorId: 'doc-123',
          date: any(named: 'date'),
        )).thenAnswer((_) async => []);

    bloc.add(const FetchDoctorAvailabilityEvent('doc-123'));
    await bloc.stream.firstWhere((s) => s is SelectTimeDateLoadedState);

    final slot = TimeSlotModel(dateTime: DateTime(2026, 10, 14, 9, 0));
    bloc.add(SelectTimeSlotEvent(slot));

    await expectLater(
      bloc.stream,
      emits(
        predicate<SelectTimeDateLoadedState>((state) {
          return state.selectedTimeSlot == slot;
        }),
      ),
    );
  });

  test('FetchDoctorAvailabilityEvent emits failure on exception', () async {
    when(() => mockRepository.getDoctorById('doc-123'))
        .thenThrow(Exception('Doctor not found'));

    bloc.add(const FetchDoctorAvailabilityEvent('doc-123'));

    await expectLater(
      bloc.stream,
      emitsInOrder([
        const SelectTimeDateLoadingState(),
        predicate<SelectTimeDateFailureState>((state) {
          return state.errorMessage.contains('Doctor not found');
        }),
      ]),
    );
  });

  test('BookAppointmentEvent emits isBooking true, then bookingSuccess true on success', () async {
    when(() => mockRepository.getDoctorById('doc-123'))
        .thenAnswer((_) async => testDoctor);
    when(() => mockRepository.getBookedAppointmentsForDate(
          doctorId: 'doc-123',
          date: any(named: 'date'),
        )).thenAnswer((_) async => []);
    final bookedSlot = TimeSlotModel(dateTime: DateTime(2026, 10, 14, 9, 0));
    when(() => mockRepository.bookAppointment(
          doctor: any(named: 'doctor'),
          selectedDate: any(named: 'selectedDate'),
          selectedTimeSlot: any(named: 'selectedTimeSlot'),
        )).thenAnswer((_) async => const AppointmentModel(
          id: 'app-new',
          doctorId: 'doc-123',
          doctorName: 'Dr. Jane Doe',
          doctorSpecialty: 'cardiology',
          patientId: 'patient-1',
          patientName: 'John',
          date: '2026-10-14',
          time: '9:00 AM',
          fee: 50,
          status: 'Upcoming',
        ));

    bloc.add(const FetchDoctorAvailabilityEvent('doc-123'));
    await bloc.stream.firstWhere((s) => s is SelectTimeDateLoadedState);

    bloc.add(BookAppointmentEvent(
      doctor: testDoctor,
      selectedDate: DateTime(2026, 10, 14),
      selectedTimeSlot: bookedSlot,
    ));

    await expectLater(
      bloc.stream,
      emitsInOrder([
        predicate<SelectTimeDateLoadedState>((state) {
          expect(state.isBooking, isTrue);
          expect(state.bookingSuccess, isFalse);
          return true;
        }),
        predicate<SelectTimeDateLoadedState>((state) {
          expect(state.isBooking, isFalse);
          expect(state.bookingSuccess, isTrue);
          final morningFormatted =
              state.morningSlots.map((s) => s.formattedTime).toList();
          expect(morningFormatted.contains('9:00 AM'), isFalse);
          return true;
        }),
      ]),
    );

    verify(() => mockRepository.bookAppointment(
          doctor: testDoctor,
          selectedDate: DateTime(2026, 10, 14),
          selectedTimeSlot: bookedSlot,
        )).called(1);
  });

  test('BookAppointmentEvent handles error gracefully', () async {
    when(() => mockRepository.getDoctorById('doc-123'))
        .thenAnswer((_) async => testDoctor);
    when(() => mockRepository.getBookedAppointmentsForDate(
          doctorId: 'doc-123',
          date: any(named: 'date'),
        )).thenAnswer((_) async => []);
    when(() => mockRepository.bookAppointment(
          doctor: any(named: 'doctor'),
          selectedDate: any(named: 'selectedDate'),
          selectedTimeSlot: any(named: 'selectedTimeSlot'),
        )).thenThrow(Exception('Booking failed'));

    bloc.add(const FetchDoctorAvailabilityEvent('doc-123'));
    await bloc.stream.firstWhere((s) => s is SelectTimeDateLoadedState);

    bloc.add(BookAppointmentEvent(
      doctor: testDoctor,
      selectedDate: DateTime(2026, 10, 14),
      selectedTimeSlot: TimeSlotModel(dateTime: DateTime(2026, 10, 14, 9, 0)),
    ));

    await expectLater(
      bloc.stream,
      emitsInOrder([
        predicate<SelectTimeDateLoadedState>((state) => state.isBooking),
        predicate<SelectTimeDateLoadedState>((state) {
          expect(state.isBooking, isFalse);
          expect(state.bookingSuccess, isFalse);
          expect(state.errorMessage, contains('Booking failed'));
          return true;
        }),
      ]),
    );
  });
}
