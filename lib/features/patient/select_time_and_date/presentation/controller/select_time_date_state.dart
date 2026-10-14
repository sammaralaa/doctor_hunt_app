import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';
import 'package:doctor_hunt_app/features/patient/select_time_and_date/data/date_slot_model.dart';
import 'package:equatable/equatable.dart';

abstract class SelectTimeDateState extends Equatable {
  const SelectTimeDateState();

  bool get isBooking => false;
  bool get bookingSuccess => false;

  @override
  List<Object?> get props => [];
}

class SelectTimeDateInitialState extends SelectTimeDateState {
  const SelectTimeDateInitialState();
}

class SelectTimeDateLoadingState extends SelectTimeDateState {
  const SelectTimeDateLoadingState();
}

class SelectTimeDateLoadedState extends SelectTimeDateState {
  final DoctorModel doctor;
  final List<DateTime> availableDays;
  final DateTime selectedDate;
  final List<TimeSlotModel> morningSlots;
  final List<TimeSlotModel> afternoonSlots;
  final List<TimeSlotModel> eveningSlots;
  final TimeSlotModel? selectedTimeSlot;
  final bool isLoadingSlots;
  @override
  final bool isBooking;
  @override
  final bool bookingSuccess;
  final String? errorMessage;

  const SelectTimeDateLoadedState({
    required this.doctor,
    required this.availableDays,
    required this.selectedDate,
    this.morningSlots = const [],
    this.afternoonSlots = const [],
    this.eveningSlots = const [],
    this.selectedTimeSlot,
    this.isLoadingSlots = false,
    this.isBooking = false,
    this.bookingSuccess = false,
    this.errorMessage,
  });

  bool get hasSlots =>
      morningSlots.isNotEmpty ||
      afternoonSlots.isNotEmpty ||
      eveningSlots.isNotEmpty;

  int get totalAvailableSlotsCount =>
      morningSlots.length + afternoonSlots.length + eveningSlots.length;

  SelectTimeDateLoadedState copyWith({
    DoctorModel? doctor,
    List<DateTime>? availableDays,
    DateTime? selectedDate,
    List<TimeSlotModel>? morningSlots,
    List<TimeSlotModel>? afternoonSlots,
    List<TimeSlotModel>? eveningSlots,
    TimeSlotModel? Function()? selectedTimeSlot,
    bool? isLoadingSlots,
    bool? isBooking,
    bool? bookingSuccess,
    String? errorMessage,
  }) {
    return SelectTimeDateLoadedState(
      doctor: doctor ?? this.doctor,
      availableDays: availableDays ?? this.availableDays,
      selectedDate: selectedDate ?? this.selectedDate,
      morningSlots: morningSlots ?? this.morningSlots,
      afternoonSlots: afternoonSlots ?? this.afternoonSlots,
      eveningSlots: eveningSlots ?? this.eveningSlots,
      selectedTimeSlot: selectedTimeSlot != null
          ? selectedTimeSlot()
          : this.selectedTimeSlot,
      isLoadingSlots: isLoadingSlots ?? this.isLoadingSlots,
      isBooking: isBooking ?? this.isBooking,
      bookingSuccess: bookingSuccess ?? this.bookingSuccess,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        doctor,
        availableDays,
        selectedDate,
        morningSlots,
        afternoonSlots,
        eveningSlots,
        selectedTimeSlot,
        isLoadingSlots,
        isBooking,
        bookingSuccess,
        errorMessage,
      ];
}

class SelectTimeDateFailureState extends SelectTimeDateState {
  final String errorMessage;

  const SelectTimeDateFailureState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
