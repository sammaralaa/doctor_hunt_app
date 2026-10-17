import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_hunt_app/core/models/appointment_model.dart';
import 'package:doctor_hunt_app/features/patient/patient_appointments/data/repos/patient_appointments_repository.dart';
import 'package:doctor_hunt_app/features/patient/patient_appointments/presentation/controller/patient_appointments_event.dart';
import 'package:doctor_hunt_app/features/patient/patient_appointments/presentation/controller/patient_appointments_state.dart';

class PatientAppointmentsBloc
    extends Bloc<PatientAppointmentsEvent, PatientAppointmentsState> {
  final PatientAppointmentsRepository repository;

  PatientAppointmentsBloc({required this.repository})
      : super(const PatientAppointmentsInitialState()) {
    on<FetchPatientAppointmentsEvent>(_onFetchPatientAppointments);
    on<CancelAppointmentEvent>(_onCancelAppointment);
  }

  Future<void> _onFetchPatientAppointments(
    FetchPatientAppointmentsEvent event,
    Emitter<PatientAppointmentsState> emit,
  ) async {
    emit(const PatientAppointmentsLoadingState());
    try {
      await emit.forEach<List<AppointmentModel>>(
        repository.getAppointments(),
        onData: (appointments) {
          final upcoming = <AppointmentModel>[];
          final completed = <AppointmentModel>[];
          final cancelled = <AppointmentModel>[];

          for (final app in appointments) {
            final status = app.status.trim().toLowerCase();
            if (status == 'completed') {
              completed.add(app);
            } else if (status == 'cancelled' || status == 'canceled') {
              cancelled.add(app);
            } else {
              upcoming.add(app);
            }
          }

          final currentState = state;
          if (currentState is PatientAppointmentsLoadedState) {
            return currentState.copyWith(
              upcomingAppointments: upcoming,
              completedAppointments: completed,
              cancelledAppointments: cancelled,
            );
          }

          return PatientAppointmentsLoadedState(
            upcomingAppointments: upcoming,
            completedAppointments: completed,
            cancelledAppointments: cancelled,
          );
        },
        onError: (error, stackTrace) =>
            PatientAppointmentsErrorState(error.toString()),
      );
    } catch (e) {
      emit(PatientAppointmentsErrorState(e.toString()));
    }
  }

  Future<void> _onCancelAppointment(
    CancelAppointmentEvent event,
    Emitter<PatientAppointmentsState> emit,
  ) async {
    final currentState = state;
    if (currentState is! PatientAppointmentsLoadedState) return;

    emit(currentState.copyWith(
      cancellingAppointmentId: () => event.appointmentId,
      cancelSuccess: false,
      cancelErrorMessage: () => null,
    ));

    try {
      await repository.cancelAppointment(appointmentId: event.appointmentId);

      final upcoming =
          List<AppointmentModel>.from(currentState.upcomingAppointments);
      final index = upcoming.indexWhere((app) => app.id == event.appointmentId);

      if (index != -1) {
        final appointment = upcoming.removeAt(index);
        final updatedAppointment = appointment.copyWith(status: 'Cancelled');
        final cancelled = [
          updatedAppointment,
          ...currentState.cancelledAppointments,
        ];

        emit(currentState.copyWith(
          upcomingAppointments: upcoming,
          cancelledAppointments: cancelled,
          cancellingAppointmentId: () => null,
          cancelSuccess: true,
          cancelErrorMessage: () => null,
        ));
      } else {
        emit(currentState.copyWith(
          cancellingAppointmentId: () => null,
          cancelSuccess: true,
          cancelErrorMessage: () => null,
        ));
      }
    } catch (e) {
      emit(currentState.copyWith(
        cancellingAppointmentId: () => null,
        cancelSuccess: false,
        cancelErrorMessage: () => e.toString(),
      ));
    }
  }
}
