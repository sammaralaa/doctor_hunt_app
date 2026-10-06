import 'package:doctor_hunt_app/features/admin/doctor_availability/data/model/doctor_availability_model.dart';
import 'package:doctor_hunt_app/features/admin/doctor_availability/data/repos/doctor_availability_repository.dart';
import 'package:doctor_hunt_app/features/admin/doctor_availability/presentation/controller/doctor_availability_event.dart';
import 'package:doctor_hunt_app/features/admin/doctor_availability/presentation/controller/doctor_availability_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorAvailabilityBloc
    extends Bloc<DoctorAvailabilityEvent, DoctorAvailabilityState> {
  final DoctorAvailabilityRepository _repository;

  DoctorAvailabilityBloc(this._repository)
      : super(const DoctorAvailabilityInitialState()) {
    on<FetchDoctorAvailabilityEvent>(_onFetchDoctorAvailability);
    on<ToggleWorkingDayEvent>(_onToggleWorkingDay);
    on<ChangeStartTimeEvent>(_onChangeStartTime);
    on<ChangeEndTimeEvent>(_onChangeEndTime);
    on<ChangeSlotDurationEvent>(_onChangeSlotDuration);
    on<SaveDoctorAvailabilityEvent>(_onSaveDoctorAvailability);
  }

  Future<void> _onFetchDoctorAvailability(
    FetchDoctorAvailabilityEvent event,
    Emitter<DoctorAvailabilityState> emit,
  ) async {
    emit(const DoctorAvailabilityLoadingState());

    try {
      final doctor = await _repository.getDoctorById(event.doctorId);
      final availability =
          doctor.availability ?? const DoctorAvailabilityModel();
      emit(DoctorAvailabilityLoadedState(
        doctor: doctor,
        availability: availability,
      ));
    } catch (e) {
      emit(DoctorAvailabilityFailureState(errorMessage: e.toString()));
    }
  }

  void _onToggleWorkingDay(
    ToggleWorkingDayEvent event,
    Emitter<DoctorAvailabilityState> emit,
  ) {
    if (state is DoctorAvailabilityLoadedState) {
      final currentState = state as DoctorAvailabilityLoadedState;
      final currentDays = List<int>.from(currentState.availability.workingDays);

      if (currentDays.contains(event.dayIndex)) {
        currentDays.remove(event.dayIndex);
      } else {
        currentDays.add(event.dayIndex);
        currentDays.sort();
      }

      final updatedAvailability = currentState.availability.copyWith(
        workingDays: currentDays,
      );

      emit(currentState.copyWith(
        availability: updatedAvailability,
        saveSuccess: false,
      ));
    }
  }

  void _onChangeStartTime(
    ChangeStartTimeEvent event,
    Emitter<DoctorAvailabilityState> emit,
  ) {
    if (state is DoctorAvailabilityLoadedState) {
      final currentState = state as DoctorAvailabilityLoadedState;
      final updatedAvailability = currentState.availability.copyWith(
        startTime: event.startTime,
      );

      emit(currentState.copyWith(
        availability: updatedAvailability,
        saveSuccess: false,
      ));
    }
  }

  void _onChangeEndTime(
    ChangeEndTimeEvent event,
    Emitter<DoctorAvailabilityState> emit,
  ) {
    if (state is DoctorAvailabilityLoadedState) {
      final currentState = state as DoctorAvailabilityLoadedState;
      final updatedAvailability = currentState.availability.copyWith(
        endTime: event.endTime,
      );

      emit(currentState.copyWith(
        availability: updatedAvailability,
        saveSuccess: false,
      ));
    }
  }

  void _onChangeSlotDuration(
    ChangeSlotDurationEvent event,
    Emitter<DoctorAvailabilityState> emit,
  ) {
    if (state is DoctorAvailabilityLoadedState) {
      final currentState = state as DoctorAvailabilityLoadedState;
      final updatedAvailability = currentState.availability.copyWith(
        slotDuration: event.slotDuration,
      );

      emit(currentState.copyWith(
        availability: updatedAvailability,
        saveSuccess: false,
      ));
    }
  }

  Future<void> _onSaveDoctorAvailability(
    SaveDoctorAvailabilityEvent event,
    Emitter<DoctorAvailabilityState> emit,
  ) async {
    if (state is DoctorAvailabilityLoadedState) {
      final currentState = state as DoctorAvailabilityLoadedState;
      final doctorId = currentState.doctor.id;

      if (doctorId == null || doctorId.isEmpty) {
        emit(currentState.copyWith(
          errorMessage: 'Invalid doctor ID',
          saveSuccess: false,
        ));
        return;
      }

      emit(currentState.copyWith(
        isSaving: true,
        saveSuccess: false,
        errorMessage: null,
      ));

      try {
        await _repository.saveDoctorAvailability(
          doctorId: doctorId,
          availability: currentState.availability,
        );

        emit(currentState.copyWith(
          isSaving: false,
          saveSuccess: true,
        ));
      } catch (e) {
        emit(currentState.copyWith(
          isSaving: false,
          saveSuccess: false,
          errorMessage: e.toString(),
        ));
      }
    }
  }
}
