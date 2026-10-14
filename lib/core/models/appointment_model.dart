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
  final String date;
  final String time;
  final num fee;
  final String status;
  final num? rating;
  final String? reviewText;

  const AppointmentModel({
    required this.id,
    required this.doctorId,
    required this.doctorName,
    required this.doctorSpecialty,
    this.doctorImage,
    required this.patientId,
    required this.patientName,
    this.patientImage,
    required this.date,
    required this.time,
    required this.fee,
    required this.status,
    this.rating,
    this.reviewText,
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
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      fee: json['fee'] ?? 0,
      status: json['status'] ?? 'Upcoming',
      rating: json['rating'],
      reviewText: json['reviewText'],
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
      'date': date,
      'time': time,
      'fee': fee,
      'status': status,
      'rating': rating,
      'reviewText': reviewText,
      'createdAt': DateTime.now().toUtc().toIso8601String(),
    };
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
    date,
    time,
    fee,
    status,
    rating,
    reviewText,
  ];
}
