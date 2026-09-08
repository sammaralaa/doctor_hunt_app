import 'package:intl/intl.dart';



extension DateTimeExtension on DateTime {
   String formatHeaderDate(DateTime date) {
    return DateFormat('EEEE, d MMM').format(date);
  }

    String formatSlotTime() {
      return DateFormat('hh:mm a').format(this);
    }
}