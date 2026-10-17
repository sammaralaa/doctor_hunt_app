import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class AppointmentModel extends Equatable {
  final String id;
  final String doctorId;
  final String doctorName;
  final String doctorSpecialty;
  final String? doctorImage;
  final String patientId;
  final String patientName;
  final String? patientImage;
  final String? patientEmail;
  final String date;
  final String time;
  final num fee;
  final String status;
  final num? rating;
  final String? reviewText;
  final String? clinicLocation;

  const AppointmentModel({
    required this.id,
    required this.doctorId,
    required this.doctorName,
    required this.doctorSpecialty,
    this.doctorImage,
    required this.patientId,
    required this.patientName,
    this.patientImage,
    this.patientEmail,
    required this.date,
    required this.time,
    required this.fee,
    required this.status,
    this.rating,
    this.reviewText,
    this.clinicLocation,
  });

  bool get isPast {
    final scheduled = parseScheduledDateTime();
    if (scheduled == null) return false;
    return scheduled.isBefore(DateTime.now());
  }

  DateTime? parseScheduledDateTime() {
    final cleanDate = date.trim();
    if (cleanDate.isEmpty) return null;

    DateTime? parsedDate = DateTime.tryParse(cleanDate);
    if (parsedDate == null) {
      for (final fmt in [
        'yyyy-MM-dd',
        'd MMM yyyy',
        'dd MMM yyyy',
        'yyyy/MM/dd',
        'd/M/yyyy',
        'dd/MM/yyyy',
        'MM/dd/yyyy',
      ]) {
        try {
          parsedDate = DateFormat(fmt).parse(cleanDate);
          break;
        } catch (_) {}
      }
    }

    if (parsedDate == null) return null;

    int hour = 0;
    int minute = 0;
    final cleanTime = time.trim().toUpperCase();
    if (cleanTime.isNotEmpty) {
      if (cleanTime.contains('AM') || cleanTime.contains('PM')) {
        for (final fmt in ['h:mm a', 'hh:mm a', 'h:mma', 'hh:mma']) {
          try {
            final t = DateFormat(fmt).parse(cleanTime);
            hour = t.hour;
            minute = t.minute;
            break;
          } catch (_) {}
        }
      } else {
        final parts = cleanTime.split(':');
        if (parts.length >= 2) {
          hour = int.tryParse(parts[0]) ?? 0;
          minute = int.tryParse(parts[1].split(' ')[0]) ?? 0;
        }
      }
    }

    return DateTime(
      parsedDate.year,
      parsedDate.month,
      parsedDate.day,
      hour,
      minute,
    );
  }

  factory AppointmentModel.fromJson(
    Map<String, dynamic> json,
    String documentId,
  ) {
    return AppointmentModel(
      id: documentId,
      doctorId: json['doctorId'] ?? '',
      doctorName: json['doctorName'] ?? '',
      doctorSpecialty: json['doctorSpecialty'] ?? '',
      doctorImage: json['doctorImage'],
      patientId: json['patientId'] ?? '',
      patientName: json['patientName'] ?? '',
      patientImage: json['patientImage'],
      patientEmail: json['patientEmail'],
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      fee: json['fee'] ?? 0,
      status: json['status'] ?? 'Upcoming',
      rating: json['rating'],
      reviewText: json['reviewText'],
      clinicLocation:
          json['clinicLocation'] ?? 'Central Clinic • 24 Garden Avenue',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'doctorId': doctorId,
      'doctorName': doctorName,
      'doctorSpecialty': doctorSpecialty,
      'doctorImage': doctorImage,
      'patientId': patientId,
      'patientName': patientName,
      'patientImage': patientImage,
      'patientEmail': patientEmail,
      'date': date,
      'time': time,
      'fee': fee,
      'status': status,
      'rating': rating,
      'reviewText': reviewText,
      'clinicLocation': clinicLocation,
      'createdAt': DateTime.now().toUtc().toIso8601String(),
    };
  }

  AppointmentModel copyWith({
    String? id,
    String? doctorId,
    String? doctorName,
    String? doctorSpecialty,
    String? doctorImage,
    String? patientId,
    String? patientName,
    String? patientImage,
    String? patientEmail,
    String? date,
    String? time,
    num? fee,
    String? status,
    num? rating,
    String? reviewText,
    String? clinicLocation,
  }) {
    return AppointmentModel(
      id: id ?? this.id,
      doctorId: doctorId ?? this.doctorId,
      doctorName: doctorName ?? this.doctorName,
      doctorSpecialty: doctorSpecialty ?? this.doctorSpecialty,
      doctorImage: doctorImage ?? this.doctorImage,
      patientId: patientId ?? this.patientId,
      patientName: patientName ?? this.patientName,
      patientImage: patientImage ?? this.patientImage,
      patientEmail: patientEmail ?? this.patientEmail,
      date: date ?? this.date,
      time: time ?? this.time,
      fee: fee ?? this.fee,
      status: status ?? this.status,
      rating: rating ?? this.rating,
      reviewText: reviewText ?? this.reviewText,
      clinicLocation: clinicLocation ?? this.clinicLocation,
    );
  }

  @override
  List<Object?> get props => [
    id,
    doctorId,
    doctorName,
    doctorSpecialty,
    doctorImage,
    patientId,
    patientName,
    patientImage,
    patientEmail,
    date,
    time,
    fee,
    status,
    rating,
    reviewText,
    clinicLocation,
  ];
}
