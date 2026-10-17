import 'package:equatable/equatable.dart';

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
