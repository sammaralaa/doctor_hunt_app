import 'package:doctor_hunt_app/core/models/appointment_model.dart';
import 'package:equatable/equatable.dart';

abstract class AppointmentDetailsState extends Equatable {
  const AppointmentDetailsState();

  @override
  List<Object?> get props => [];
}

class AppointmentDetailsInitialState extends AppointmentDetailsState {
  const AppointmentDetailsInitialState();
}

class AppointmentDetailsLoadingState extends AppointmentDetailsState {
  const AppointmentDetailsLoadingState();
}

class AppointmentDetailsLoadedState extends AppointmentDetailsState {
  final AppointmentModel appointment;
  final bool isProcessing;
  final String? successMessage;
  final String? errorMessage;

  const AppointmentDetailsLoadedState({
    required this.appointment,
    this.isProcessing = false,
    this.successMessage,
    this.errorMessage,
  });

  AppointmentDetailsLoadedState copyWith({
    AppointmentModel? appointment,
    bool? isProcessing,
    String? Function()? successMessage,
    String? Function()? errorMessage,
  }) {
    return AppointmentDetailsLoadedState(
      appointment: appointment ?? this.appointment,
      isProcessing: isProcessing ?? this.isProcessing,
      successMessage:
          successMessage != null ? successMessage() : this.successMessage,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        appointment,
        isProcessing,
        successMessage,
        errorMessage,
      ];
}

class AppointmentDetailsErrorState extends AppointmentDetailsState {
  final String errorMessage;

  const AppointmentDetailsErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
