import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_hunt_app/core/models/appointment_model.dart';
import 'package:doctor_hunt_app/features/admin/admin_appointments/data/repos/admin_appointments_repository.dart';
import 'package:doctor_hunt_app/features/admin/admin_appointments/presentation/controller/admin_appointments_event.dart';
import 'package:doctor_hunt_app/features/admin/admin_appointments/presentation/controller/admin_appointments_state.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';

class AdminAppointmentsBloc
    extends Bloc<AdminAppointmentsEvent, AdminAppointmentsState> {
  final AdminAppointmentsRepository repository;

  AdminAppointmentsBloc({required this.repository})
      : super(const AdminAppointmentsInitialState()) {
    on<LoadAdminAppointmentsEvent>(_onLoadAdminAppointments);
    on<ChangeFilterEvent>(_onChangeFilter);
    on<CancelAppointmentEvent>(_onCancelAppointment);
    on<MarkAsCompletedEvent>(_onMarkAsCompleted);
  }

  Future<void> _onLoadAdminAppointments(
    LoadAdminAppointmentsEvent event,
    Emitter<AdminAppointmentsState> emit,
  ) async {
    emit(const AdminAppointmentsLoadingState());
    try {
      await emit.forEach<List<AppointmentModel>>(
        repository.fetchAllAppointments(),
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
          if (currentState is AdminAppointmentsLoadedState) {
            return currentState.copyWith(
              upcomingAppointments: upcoming,
              completedAppointments: completed,
              cancelledAppointments: cancelled,
            );
          }

          return AdminAppointmentsLoadedState(
            upcomingAppointments: upcoming,
            completedAppointments: completed,
            cancelledAppointments: cancelled,
          );
        },
        onError: (error, stackTrace) =>
            AdminAppointmentsErrorState(error.toString()),
      );
    } catch (e) {
      emit(AdminAppointmentsErrorState(e.toString()));
    }
  }

  void _onChangeFilter(
    ChangeFilterEvent event,
    Emitter<AdminAppointmentsState> emit,
  ) {
    final currentState = state;
    if (currentState is AdminAppointmentsLoadedState) {
      emit(currentState.copyWith(selectedFilter: event.filter));
    }
  }

  Future<void> _onCancelAppointment(
    CancelAppointmentEvent event,
    Emitter<AdminAppointmentsState> emit,
  ) async {
    final currentState = state;
    if (currentState is! AdminAppointmentsLoadedState) return;

    emit(currentState.copyWith(
      operatingAppointmentId: () => event.appointmentId,
      successMessage: () => null,
      errorMessage: () => null,
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
          operatingAppointmentId: () => null,
          successMessage: () => t.appointmentCancelledSuccessfully,
          errorMessage: () => null,
        ));
      } else {
        emit(currentState.copyWith(
          operatingAppointmentId: () => null,
          successMessage: () => t.appointmentCancelledSuccessfully,
          errorMessage: () => null,
        ));
      }
    } catch (e) {
      emit(currentState.copyWith(
        operatingAppointmentId: () => null,
        successMessage: () => null,
        errorMessage: () => e.toString(),
      ));
    }
  }

  Future<void> _onMarkAsCompleted(
    MarkAsCompletedEvent event,
    Emitter<AdminAppointmentsState> emit,
  ) async {
    final currentState = state;
    if (currentState is! AdminAppointmentsLoadedState) return;

    emit(currentState.copyWith(
      operatingAppointmentId: () => event.appointmentId,
      successMessage: () => null,
      errorMessage: () => null,
    ));

    try {
      await repository.markAsCompleted(appointmentId: event.appointmentId);
      final upcoming =
          List<AppointmentModel>.from(currentState.upcomingAppointments);
      final index = upcoming.indexWhere((app) => app.id == event.appointmentId);

      if (index != -1) {
        final appointment = upcoming.removeAt(index);
        final updatedAppointment = appointment.copyWith(status: 'Completed');
        final completed = [
          updatedAppointment,
          ...currentState.completedAppointments,
        ];
        emit(currentState.copyWith(
          upcomingAppointments: upcoming,
          completedAppointments: completed,
          operatingAppointmentId: () => null,
          successMessage: () => t.appointmentCompletedSuccessfully,
          errorMessage: () => null,
        ));
      } else {
        emit(currentState.copyWith(
          operatingAppointmentId: () => null,
          successMessage: () => t.appointmentCompletedSuccessfully,
          errorMessage: () => null,
        ));
      }
    } catch (e) {
      emit(currentState.copyWith(
        operatingAppointmentId: () => null,
        successMessage: () => null,
        errorMessage: () => e.toString(),
      ));
    }
  }
}
