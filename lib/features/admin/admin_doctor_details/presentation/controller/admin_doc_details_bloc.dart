import 'package:doctor_hunt_app/features/admin/admin_doctor_details/data/repos/admin_doc_details_repository.dart';
import 'package:doctor_hunt_app/features/admin/admin_doctor_details/presentation/controller/admin_doc_details_event.dart';
import 'package:doctor_hunt_app/features/admin/admin_doctor_details/presentation/controller/admin_doc_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminDocDetailsBloc
    extends Bloc<AdminDocDetailsEvent, AdminDocDetailsState> {
  final AdminDocDetailsRepository _docDetailsRepository;

  AdminDocDetailsBloc(this._docDetailsRepository)
    : super(DoctorDetailsInitialState()) {
    on<FetchDoctorDetailsEvent>(_onFetchDoctorDetails);
    on<DeleteDoctorEvent>(_onDeleteDoctor);
    on<ChangeDoctorStatusEvent>(_onChangeDoctorStatus);
    //on<GetUserProfileDataEvent>(_onGetUserProfileData);
  }

  Future<void> _onFetchDoctorDetails(
    FetchDoctorDetailsEvent event,
    Emitter<AdminDocDetailsState> emit,
  ) async {
    emit(DoctorDetailsLoadingState());
    final docotr = await _docDetailsRepository.getDoctorById(event.docotrId);
    emit(FetchDoctorDetailsSuccessState(doctor: docotr));
    try {} catch (e) {
      emit(DoctorDetailsFailureState(e.toString()));
    }
  }

  Future<void> _onDeleteDoctor(
    DeleteDoctorEvent event,
    Emitter<AdminDocDetailsState> emit,
  ) async {
    emit(DoctorDetailsLoadingState());
    try {
      await _docDetailsRepository.deleteDoctor(event.doctorId);
      emit(DeleteDoctorSuccessState());
    } catch (e) {
      emit(DoctorDetailsFailureState(e.toString()));
    }
  }

  Future<void> _onChangeDoctorStatus(
    ChangeDoctorStatusEvent event,
    Emitter<AdminDocDetailsState> emit,
  ) async {
    try {
      final newStatus = !event.isActive;

      await _docDetailsRepository.updateDoctorStatus(
        doctorId: event.doctorId,
        isActive: newStatus,
      );

      emit(
        ChangeStatusSuccessState(
          doctorId: event.doctorId,
          newStatus: newStatus,
        ),
      );
    } catch (e) {
      emit(DoctorDetailsFailureState(e.toString()));
    }
  }
}
