import 'package:equatable/equatable.dart';
import 'package:doctor_hunt_app/core/models/appointment_model.dart';

abstract class PatientAppointmentsState extends Equatable {
  const PatientAppointmentsState();

  @override
  List<Object?> get props => [];
}

class PatientAppointmentsInitialState extends PatientAppointmentsState {
  const PatientAppointmentsInitialState();
}

class PatientAppointmentsLoadingState extends PatientAppointmentsState {
  const PatientAppointmentsLoadingState();
}

class PatientAppointmentsLoadedState extends PatientAppointmentsState {
  final List<AppointmentModel> upcomingAppointments;
  final List<AppointmentModel> completedAppointments;
  final List<AppointmentModel> cancelledAppointments;
  final String? cancellingAppointmentId;
  final bool cancelSuccess;
  final String? cancelErrorMessage;

  const PatientAppointmentsLoadedState({
    required this.upcomingAppointments,
    required this.completedAppointments,
    required this.cancelledAppointments,
    this.cancellingAppointmentId,
    this.cancelSuccess = false,
    this.cancelErrorMessage,
  });

  bool isCancelling(String appointmentId) =>
      cancellingAppointmentId == appointmentId;

  PatientAppointmentsLoadedState copyWith({
    List<AppointmentModel>? upcomingAppointments,
    List<AppointmentModel>? completedAppointments,
    List<AppointmentModel>? cancelledAppointments,
    String? Function()? cancellingAppointmentId,
    bool? cancelSuccess,
    String? Function()? cancelErrorMessage,
  }) {
    return PatientAppointmentsLoadedState(
      upcomingAppointments: upcomingAppointments ?? this.upcomingAppointments,
      completedAppointments:
          completedAppointments ?? this.completedAppointments,
      cancelledAppointments:
          cancelledAppointments ?? this.cancelledAppointments,
      cancellingAppointmentId: cancellingAppointmentId != null
          ? cancellingAppointmentId()
          : this.cancellingAppointmentId,
      cancelSuccess: cancelSuccess ?? this.cancelSuccess,
      cancelErrorMessage: cancelErrorMessage != null
          ? cancelErrorMessage()
          : this.cancelErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
        upcomingAppointments,
        completedAppointments,
        cancelledAppointments,
        cancellingAppointmentId,
        cancelSuccess,
        cancelErrorMessage,
      ];
}

class PatientAppointmentsErrorState extends PatientAppointmentsState {
  final String errorMessage;

  const PatientAppointmentsErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
