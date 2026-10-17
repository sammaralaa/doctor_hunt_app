import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_hunt_app/features/common/appointment_details/data/repos/appointment_details_repository.dart';
import 'package:doctor_hunt_app/features/common/appointment_details/presentation/controller/appointment_details_event.dart';
import 'package:doctor_hunt_app/features/common/appointment_details/presentation/controller/appointment_details_state.dart';

class AppointmentDetailsBloc
    extends Bloc<AppointmentDetailsEvent, AppointmentDetailsState> {
  final AppointmentDetailsRepository repository;

  AppointmentDetailsBloc({required this.repository})
      : super(const AppointmentDetailsInitialState()) {
    on<FetchAppointmentDetailsEvent>(_onFetchAppointmentDetails);
    on<CancelAppointmentDetailEvent>(_onCancelAppointment);
    on<MarkAppointmentCompletedDetailEvent>(_onMarkAppointmentCompleted);
  }

  Future<void> _onFetchAppointmentDetails(
    FetchAppointmentDetailsEvent event,
    Emitter<AppointmentDetailsState> emit,
  ) async {
    emit(const AppointmentDetailsLoadingState());
    try {
      final appointment =
          await repository.getAppointmentById(event.appointmentId);
      emit(AppointmentDetailsLoadedState(appointment: appointment));
    } catch (e) {
      emit(AppointmentDetailsErrorState(e.toString()));
    }
  }

  Future<void> _onCancelAppointment(
    CancelAppointmentDetailEvent event,
    Emitter<AppointmentDetailsState> emit,
  ) async {
    final currentState = state;
    if (currentState is! AppointmentDetailsLoadedState) return;

    emit(currentState.copyWith(
      isProcessing: true,
      successMessage: () => null,
      errorMessage: () => null,
    ));

    try {
      await repository.cancelAppointment(appointmentId: event.appointmentId);
      final updatedAppointment =
          currentState.appointment.copyWith(status: 'Cancelled');
      emit(currentState.copyWith(
        appointment: updatedAppointment,
        isProcessing: false,
        successMessage: () => 'Appointment cancelled successfully',
      ));
    } catch (e) {
      emit(currentState.copyWith(
        isProcessing: false,
        errorMessage: () => e.toString(),
      ));
    }
  }

  Future<void> _onMarkAppointmentCompleted(
    MarkAppointmentCompletedDetailEvent event,
    Emitter<AppointmentDetailsState> emit,
  ) async {
    final currentState = state;
    if (currentState is! AppointmentDetailsLoadedState) return;

    emit(currentState.copyWith(
      isProcessing: true,
      successMessage: () => null,
      errorMessage: () => null,
    ));

    try {
      await repository.markAppointmentCompleted(
          appointmentId: event.appointmentId);
      final updatedAppointment =
          currentState.appointment.copyWith(status: 'Completed');
      emit(currentState.copyWith(
        appointment: updatedAppointment,
        isProcessing: false,
        successMessage: () => 'Appointment marked as completed successfully',
      ));
    } catch (e) {
      emit(currentState.copyWith(
        isProcessing: false,
        errorMessage: () => e.toString(),
      ));
    }
  }
}
