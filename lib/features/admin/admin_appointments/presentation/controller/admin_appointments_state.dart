import 'package:equatable/equatable.dart';
import 'package:doctor_hunt_app/core/models/appointment_model.dart';

enum AppointmentFilter { upcoming, completed, cancelled }

abstract class AdminAppointmentsState extends Equatable {
  const AdminAppointmentsState();

  @override
  List<Object?> get props => [];
}

class AdminAppointmentsInitialState extends AdminAppointmentsState {
  const AdminAppointmentsInitialState();
}

class AdminAppointmentsLoadingState extends AdminAppointmentsState {
  const AdminAppointmentsLoadingState();
}

class AdminAppointmentsLoadedState extends AdminAppointmentsState {
  final List<AppointmentModel> upcomingAppointments;
  final List<AppointmentModel> completedAppointments;
  final List<AppointmentModel> cancelledAppointments;
  final AppointmentFilter selectedFilter;
  final String? operatingAppointmentId;
  final String? successMessage;
  final String? errorMessage;

  const AdminAppointmentsLoadedState({
    required this.upcomingAppointments,
    required this.completedAppointments,
    required this.cancelledAppointments,
    this.selectedFilter = AppointmentFilter.upcoming,
    this.operatingAppointmentId,
    this.successMessage,
    this.errorMessage,
  });

  List<AppointmentModel> get appointments {
    switch (selectedFilter) {
      case AppointmentFilter.upcoming:
        return upcomingAppointments;
      case AppointmentFilter.completed:
        return completedAppointments;
      case AppointmentFilter.cancelled:
        return cancelledAppointments;
    }
  }

  bool isOperating(String appointmentId) =>
      operatingAppointmentId == appointmentId;

  AdminAppointmentsLoadedState copyWith({
    List<AppointmentModel>? upcomingAppointments,
    List<AppointmentModel>? completedAppointments,
    List<AppointmentModel>? cancelledAppointments,
    AppointmentFilter? selectedFilter,
    String? Function()? operatingAppointmentId,
    String? Function()? successMessage,
    String? Function()? errorMessage,
  }) {
    return AdminAppointmentsLoadedState(
      upcomingAppointments:
          upcomingAppointments ?? this.upcomingAppointments,
      completedAppointments:
          completedAppointments ?? this.completedAppointments,
      cancelledAppointments:
          cancelledAppointments ?? this.cancelledAppointments,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      operatingAppointmentId: operatingAppointmentId != null
          ? operatingAppointmentId()
          : this.operatingAppointmentId,
      successMessage: successMessage != null
          ? successMessage()
          : this.successMessage,
      errorMessage: errorMessage != null
          ? errorMessage()
          : this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        upcomingAppointments,
        completedAppointments,
        cancelledAppointments,
        selectedFilter,
        operatingAppointmentId,
        successMessage,
        errorMessage,
      ];
}

class AdminAppointmentsErrorState extends AdminAppointmentsState {
  final String errorMessage;

  const AdminAppointmentsErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
