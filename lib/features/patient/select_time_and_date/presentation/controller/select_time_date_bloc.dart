import 'package:doctor_hunt_app/core/models/appointment_model.dart';
import 'package:doctor_hunt_app/features/admin/doctor_availability/data/model/doctor_availability_model.dart';
import 'package:doctor_hunt_app/features/patient/select_time_and_date/data/date_slot_model.dart';
import 'package:doctor_hunt_app/features/patient/select_time_and_date/data/repos/select_time_date_repository.dart';
import 'package:doctor_hunt_app/features/patient/select_time_and_date/presentation/controller/select_time_date_event.dart';
import 'package:doctor_hunt_app/features/patient/select_time_and_date/presentation/controller/select_time_date_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SelectTimeDateBloc
    extends Bloc<SelectTimeDateEvent, SelectTimeDateState> {
  final SelectTimeDateRepository repository;

  SelectTimeDateBloc({required this.repository})
    : super(const SelectTimeDateInitialState()) {
    on<FetchDoctorAvailabilityEvent>(_onFetchDoctorAvailability);
    on<SelectDateEvent>(_onSelectDate);
    on<SelectTimeSlotEvent>(_onSelectTimeSlot);
    on<BookAppointmentEvent>(_onBookAppointment);
  }

  Future<void> _onFetchDoctorAvailability(
    FetchDoctorAvailabilityEvent event,
    Emitter<SelectTimeDateState> emit,
  ) async {
    emit(const SelectTimeDateLoadingState());
    try {
      final doctor = await repository.getDoctorById(event.doctorId);
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      // Generate next 14 days
      final availableDays = List.generate(
        7,
        (index) => today.add(Duration(days: index)),
      );

      final initialDate = today;
      final availability =
          doctor.availability ?? const DoctorAvailabilityModel();

      final bookedAppointments = await repository.getBookedAppointmentsForDate(
        doctorId: doctor.id ?? event.doctorId,
        date: initialDate,
      );

      final slotResult = _generateAndCategorizeSlots(
        date: initialDate,
        availability: availability,
        bookedAppointments: bookedAppointments,
      );

      emit(
        SelectTimeDateLoadedState(
          doctor: doctor,
          availableDays: availableDays,
          selectedDate: initialDate,
          morningSlots: slotResult.morning,
          afternoonSlots: slotResult.afternoon,
          eveningSlots: slotResult.evening,
        ),
      );
    } catch (e) {
      emit(SelectTimeDateFailureState(errorMessage: e.toString()));
    }
  }

  Future<void> _onSelectDate(
    SelectDateEvent event,
    Emitter<SelectTimeDateState> emit,
  ) async {
    final currentState = state;
    if (currentState is! SelectTimeDateLoadedState) return;

    emit(
      currentState.copyWith(
        selectedDate: event.date,
        isLoadingSlots: true,
        selectedTimeSlot: () => null,
      ),
    );

    try {
      final availability =
          currentState.doctor.availability ?? const DoctorAvailabilityModel();

      final bookedAppointments = await repository.getBookedAppointmentsForDate(
        doctorId: currentState.doctor.id ?? '',
        date: event.date,
      );

      final slotResult = _generateAndCategorizeSlots(
        date: event.date,
        availability: availability,
        bookedAppointments: bookedAppointments,
      );

      emit(
        currentState.copyWith(
          selectedDate: event.date,
          morningSlots: slotResult.morning,
          afternoonSlots: slotResult.afternoon,
          eveningSlots: slotResult.evening,
          isLoadingSlots: false,
        ),
      );
    } catch (e) {
      emit(
        currentState.copyWith(
          isLoadingSlots: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onSelectTimeSlot(
    SelectTimeSlotEvent event,
    Emitter<SelectTimeDateState> emit,
  ) {
    final currentState = state;
    if (currentState is! SelectTimeDateLoadedState) return;

    emit(currentState.copyWith(selectedTimeSlot: () => event.slot));
  }

  Future<void> _onBookAppointment(
    BookAppointmentEvent event,
    Emitter<SelectTimeDateState> emit,
  ) async {
    final currentState = state;
    if (currentState is! SelectTimeDateLoadedState) return;

    emit(
      currentState.copyWith(
        isBooking: true,
        bookingSuccess: false,
        errorMessage: null,
      ),
    );

    try {
      final bookedAppointment = await repository.bookAppointment(
        doctor: event.doctor,
        selectedDate: event.selectedDate,
        selectedTimeSlot: event.selectedTimeSlot,
      );

      final updatedMorning = currentState.morningSlots
          .where((s) => !_isSlotBooked(s, [bookedAppointment]))
          .toList();
      final updatedAfternoon = currentState.afternoonSlots
          .where((s) => !_isSlotBooked(s, [bookedAppointment]))
          .toList();
      final updatedEvening = currentState.eveningSlots
          .where((s) => !_isSlotBooked(s, [bookedAppointment]))
          .toList();

      emit(
        currentState.copyWith(
          isBooking: false,
          bookingSuccess: true,
          morningSlots: updatedMorning,
          afternoonSlots: updatedAfternoon,
          eveningSlots: updatedEvening,
          selectedTimeSlot: () => null,
        ),
      );
    } catch (e) {
      emit(
        currentState.copyWith(
          isBooking: false,
          bookingSuccess: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  ({
    List<TimeSlotModel> morning,
    List<TimeSlotModel> afternoon,
    List<TimeSlotModel> evening,
  })
  _generateAndCategorizeSlots({
    required DateTime date,
    required DoctorAvailabilityModel availability,
    required List<AppointmentModel> bookedAppointments,
  }) {
    if (!availability.workingDays.contains(date.weekday)) {
      return (
        morning: <TimeSlotModel>[],
        afternoon: <TimeSlotModel>[],
        evening: <TimeSlotModel>[],
      );
    }

    final startTime = _parseTime(
      availability.startTime,
      const TimeOfDay(hour: 9, minute: 0),
    );
    final endTime = _parseTime(
      availability.endTime,
      const TimeOfDay(hour: 17, minute: 0),
    );

    final startMinutes = startTime.hour * 60 + startTime.minute;
    final endMinutes = endTime.hour * 60 + endTime.minute;
    final duration = availability.slotDuration > 0
        ? availability.slotDuration
        : 30;

    final List<TimeSlotModel> generated = [];
    for (int m = startMinutes; m + duration <= endMinutes; m += duration) {
      final hour = m ~/ 60;
      final minute = m % 60;
      final slotDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        hour,
        minute,
      );
      generated.add(TimeSlotModel(dateTime: slotDateTime));
    }

    final available = generated
        .where((slot) => !_isSlotBooked(slot, bookedAppointments))
        .toList();

    // morning: opening until 11:59 AM (hour < 12)
    final morning = available.where((s) => s.isMorning).toList();
    // afternoon: 12:00 PM to 4:59 PM (hour >= 12 && hour < 17)
    final afternoon = available.where((s) => s.isAfternoon).toList();
    // evening: 5:00 PM onwards (hour >= 17)
    final evening = available.where((s) => s.isEvening).toList();

    return (morning: morning, afternoon: afternoon, evening: evening);
  }

  bool _isSlotBooked(
    TimeSlotModel slot,
    List<AppointmentModel> bookedAppointments,
  ) {
    for (final app in bookedAppointments) {
      if (app.status.toLowerCase() == 'cancelled') continue;

      final appTime = app.time.trim();
      if (appTime.isEmpty) continue;

      if (slot.formattedTime.toLowerCase() == appTime.toLowerCase()) {
        return true;
      }

      final hhmmA = DateFormat('hh:mm a').format(slot.dateTime);
      if (hhmmA.toLowerCase() == appTime.toLowerCase()) {
        return true;
      }

      final format24 = DateFormat('HH:mm').format(slot.dateTime);
      if (format24 == appTime) {
        return true;
      }

      final parsed = _parseTime(appTime, const TimeOfDay(hour: -1, minute: -1));
      if (parsed.hour == slot.dateTime.hour &&
          parsed.minute == slot.dateTime.minute) {
        return true;
      }
    }
    return false;
  }

  TimeOfDay _parseTime(String timeStr, TimeOfDay fallback) {
    try {
      final trimmed = timeStr.trim().toUpperCase();
      if (trimmed.contains('AM') || trimmed.contains('PM')) {
        try {
          final dt = DateFormat('h:mm a').parse(trimmed);
          return TimeOfDay(hour: dt.hour, minute: dt.minute);
        } catch (_) {
          final dt = DateFormat('hh:mm a').parse(trimmed);
          return TimeOfDay(hour: dt.hour, minute: dt.minute);
        }
      }
      final parts = trimmed.split(':');
      if (parts.length >= 2) {
        final hour = int.parse(parts[0]);
        final minute = int.parse(parts[1].split(' ')[0]);
        return TimeOfDay(hour: hour, minute: minute);
      }
    } catch (_) {}
    return fallback;
  }
}
