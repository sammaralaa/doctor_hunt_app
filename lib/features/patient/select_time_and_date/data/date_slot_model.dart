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
    if (timeSlots.isEmpty) return t.noSlotsAvailable;
    return t.slotsAvailable(count: timeSlots.length);
  }

  @override
  List<Object?> get props => [date, timeSlots];
}

class TimeSlotModel extends Equatable {
  final DateTime dateTime;

  const TimeSlotModel({required this.dateTime});

  String get formattedTime => DateFormat('h:mm a').format(dateTime);

  bool get isMorning => dateTime.hour < 12;
  bool get isAfternoon => dateTime.hour >= 12 && dateTime.hour < 17;
  bool get isEvening => dateTime.hour >= 17;

  @override
  List<Object?> get props => [dateTime];
}