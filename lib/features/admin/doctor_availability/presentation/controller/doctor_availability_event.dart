import 'package:equatable/equatable.dart';

abstract class DoctorAvailabilityEvent extends Equatable {
  const DoctorAvailabilityEvent();

  @override
  List<Object?> get props => [];
}

class FetchDoctorAvailabilityEvent extends DoctorAvailabilityEvent {
  final String doctorId;

  const FetchDoctorAvailabilityEvent({required this.doctorId});

  @override
  List<Object?> get props => [doctorId];
}

class ToggleWorkingDayEvent extends DoctorAvailabilityEvent {
  final int dayIndex;

  const ToggleWorkingDayEvent({required this.dayIndex});

  @override
  List<Object?> get props => [dayIndex];
}

class ChangeStartTimeEvent extends DoctorAvailabilityEvent {
  final String startTime;

  const ChangeStartTimeEvent({required this.startTime});

  @override
  List<Object?> get props => [startTime];
}

class ChangeEndTimeEvent extends DoctorAvailabilityEvent {
  final String endTime;

  const ChangeEndTimeEvent({required this.endTime});

  @override
  List<Object?> get props => [endTime];
}

class ChangeSlotDurationEvent extends DoctorAvailabilityEvent {
  final int slotDuration;

  const ChangeSlotDurationEvent({required this.slotDuration});

  @override
  List<Object?> get props => [slotDuration];
}

class SaveDoctorAvailabilityEvent extends DoctorAvailabilityEvent {
  const SaveDoctorAvailabilityEvent();
}
