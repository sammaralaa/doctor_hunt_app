import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class DaySlotModel extends Equatable {
  final DateTime date;
  final List<TimeSlotModel> timeSlots;

  const DaySlotModel({
    required this.date,
    this.timeSlots = const [],
  });

  String get dayLabel {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final targetDate = DateTime(date.year, date.month, date.day);

    if (targetDate.difference(today).inDays == 0) {
      return '${t.today}, ${DateFormat('d MMM').format(date)}';
    } else if (targetDate.difference(today).inDays == 1) {
      return '${t.tomorrow}, ${DateFormat('d MMM').format(date)}';
    }
    return DateFormat('EEE, d MMM').format(date);
  }

  String get availabilityText {
    final availableCount = timeSlots.where((s) => s.isAvailable).length;
    if (availableCount == 0) return t.noSlotsAvailable;
    return t.slotsAvailable(count: availableCount);
  }

  @override
  List<Object?> get props => [date, timeSlots];
}

class TimeSlotModel extends Equatable {
  final DateTime dateTime;
  final bool isBooked;
  final bool isPast;

  const TimeSlotModel({
    required this.dateTime,
    this.isBooked = false,
    this.isPast = false,
  });

  bool get isDisabled => isBooked || isPast;
  bool get isAvailable => !isDisabled;

  String get formattedTime => DateFormat('h:mm a').format(dateTime);

  bool get isMorning => dateTime.hour < 12;
  bool get isAfternoon => dateTime.hour >= 12 && dateTime.hour < 17;
  bool get isEvening => dateTime.hour >= 17;

  TimeSlotModel copyWith({
    DateTime? dateTime,
    bool? isBooked,
    bool? isPast,
  }) {
    return TimeSlotModel(
      dateTime: dateTime ?? this.dateTime,
      isBooked: isBooked ?? this.isBooked,
      isPast: isPast ?? this.isPast,
    );
  }

  @override
  List<Object?> get props => [dateTime, isBooked, isPast];
}