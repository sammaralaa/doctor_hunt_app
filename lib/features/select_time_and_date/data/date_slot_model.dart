import 'package:intl/intl.dart';

class DaySlotModel {
  final DateTime date;
  final List<TimeSlotModel> timeSlots;

  DaySlotModel({
    required this.date,
    required this.timeSlots,
  });

  String get dayLabel {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final targetDate = DateTime(date.year, date.month, date.day);

    if (targetDate.difference(today).inDays == 0) {
      return 'Today, ${DateFormat('d MMM').format(date)}';
    } else if (targetDate.difference(today).inDays == 1) {
      return 'Tomorrow, ${DateFormat('d MMM').format(date)}';
    }
    return DateFormat('EEE, d MMM').format(date);
  }

  String get availabilityText {
    if (timeSlots.isEmpty) return 'No slots available';
    return '${timeSlots.length} slots available';
  }
}

class TimeSlotModel {
  final DateTime dateTime;

  TimeSlotModel({required this.dateTime});

  String get formattedTime => DateFormat('h:mm a').format(dateTime);

  bool get isAfternoon => dateTime.hour < 17;
}

///////
 final List<DaySlotModel> dummyDays = [
  DaySlotModel(
    date: DateTime(2026, 2, 23),
    timeSlots: [],
  ),
  DaySlotModel(
    date: DateTime(2026, 2, 24),
    timeSlots: [
      // Afternoon
      TimeSlotModel(dateTime: DateTime(2026, 2, 24, 13, 0)),
      TimeSlotModel(dateTime: DateTime(2026, 2, 24, 13, 30)),
      TimeSlotModel(dateTime: DateTime(2026, 2, 24, 14, 0)),
      TimeSlotModel(dateTime: DateTime(2026, 2, 24, 14, 30)),
      TimeSlotModel(dateTime: DateTime(2026, 2, 24, 15, 0)),
      TimeSlotModel(dateTime: DateTime(2026, 2, 24, 15, 30)),
      TimeSlotModel(dateTime: DateTime(2026, 2, 24, 16, 0)),
      // Evening
      TimeSlotModel(dateTime: DateTime(2026, 2, 24, 17, 0)),
      TimeSlotModel(dateTime: DateTime(2026, 2, 24, 17, 30)),
      TimeSlotModel(dateTime: DateTime(2026, 2, 24, 18, 0)),
      TimeSlotModel(dateTime: DateTime(2026, 2, 24, 18, 30)),
      TimeSlotModel(dateTime: DateTime(2026, 2, 24, 19, 0)),
    ],
  ),
  DaySlotModel(
    date: DateTime(2026, 2, 25),
    timeSlots: [
      TimeSlotModel(dateTime: DateTime(2026, 2, 25, 10, 0)),
      TimeSlotModel(dateTime: DateTime(2026, 2, 25, 11, 0)),
    ],
  ),
];