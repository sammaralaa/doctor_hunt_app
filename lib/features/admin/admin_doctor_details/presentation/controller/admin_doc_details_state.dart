abstract class AdminDocDetailsState {}

class DoctorDetailsInitialState extends AdminDocDetailsState {}

class DoctorDetailsLoadingState extends AdminDocDetailsState {}
class ChangeStatusSuccessState extends AdminDocDetailsState{
  final String doctorId;
  final bool newStatus;

  ChangeStatusSuccessState({
    required this.doctorId,
    required this.newStatus,
  });
}
class DeleteDoctorSuccessState extends AdminDocDetailsState {}
class UpdateDoctorSuccessState extends AdminDocDetailsState {}

class DoctorDetailsFailureState extends AdminDocDetailsState {
  final String errorMessage;

  DoctorDetailsFailureState(this.errorMessage);
}
