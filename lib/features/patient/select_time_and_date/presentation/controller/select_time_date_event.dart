import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';
import 'package:doctor_hunt_app/features/patient/select_time_and_date/data/date_slot_model.dart';
import 'package:equatable/equatable.dart';

abstract class SelectTimeDateEvent extends Equatable {
  const SelectTimeDateEvent();

  @override
  List<Object?> get props => [];
}

class FetchDoctorAvailabilityEvent extends SelectTimeDateEvent {
  final String doctorId;

  const FetchDoctorAvailabilityEvent(this.doctorId);

  @override
  List<Object?> get props => [doctorId];
}

class SelectDateEvent extends SelectTimeDateEvent {
  final DateTime date;

  const SelectDateEvent(this.date);

  @override
  List<Object?> get props => [date];
}

class SelectTimeSlotEvent extends SelectTimeDateEvent {
  final TimeSlotModel slot;

  const SelectTimeSlotEvent(this.slot);

  @override
  List<Object?> get props => [slot];
}

class BookAppointmentEvent extends SelectTimeDateEvent {
  final DoctorModel doctor;
  final DateTime selectedDate;
  final TimeSlotModel selectedTimeSlot;

  const BookAppointmentEvent({
    required this.doctor,
    required this.selectedDate,
    required this.selectedTimeSlot,
  });

  @override
  List<Object?> get props => [doctor, selectedDate, selectedTimeSlot];
}
