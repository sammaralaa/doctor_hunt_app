import 'package:intl/intl.dart';

abstract class DateFormatter {
  static String formatHeaderDate(DateTime date) {
    return DateFormat('EEEE, d MMM').format(date);
  }

  static String formatSlotTime(DateTime date) {
    return DateFormat('hh:mm a').format(date);
  }
}