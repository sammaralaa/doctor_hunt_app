import 'package:equatable/equatable.dart';

class DoctorAvailabilityModel extends Equatable {
  final List<int> workingDays;
  final String startTime;
  final String endTime;
  final int slotDuration;

  const DoctorAvailabilityModel({
    this.workingDays = const [1, 2, 3, 4, 5],
    this.startTime = '09:00',
    this.endTime = '17:00',
    this.slotDuration = 30,
  });

  Map<String, dynamic> toMap() {
    return {
      'workingDays': workingDays,
      'startTime': startTime,
      'endTime': endTime,
      'slotDuration': slotDuration,
    };
  }

  Map<String, dynamic> toJson() => toMap();

  factory DoctorAvailabilityModel.fromMap(Map<String, dynamic> map) {
    return DoctorAvailabilityModel(
      workingDays: (map['workingDays'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [1, 2, 3, 4, 5],
      startTime: map['startTime'] as String? ?? '09:00',
      endTime: map['endTime'] as String? ?? '17:00',
      slotDuration: (map['slotDuration'] as num?)?.toInt() ?? 30,
    );
  }

  factory DoctorAvailabilityModel.fromJson(Map<String, dynamic> json) =>
      DoctorAvailabilityModel.fromMap(json);

  DoctorAvailabilityModel copyWith({
    List<int>? workingDays,
    String? startTime,
    String? endTime,
    int? slotDuration,
  }) {
    return DoctorAvailabilityModel(
      workingDays: workingDays ?? this.workingDays,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      slotDuration: slotDuration ?? this.slotDuration,
    );
  }

  @override
  List<Object?> get props => [workingDays, startTime, endTime, slotDuration];
}
