abstract class AdminDocDetailsEvent {
  const AdminDocDetailsEvent();
}

class DeleteDoctorEvent extends AdminDocDetailsEvent {
  final String doctorId;

  const DeleteDoctorEvent({required this.doctorId});
}

class FetchDoctorDetailsEvent extends AdminDocDetailsEvent {
  final String docotrId;
  FetchDoctorDetailsEvent({required this.docotrId});
}

class ChangeDoctorStatusEvent extends AdminDocDetailsEvent {
  final String doctorId;
  final bool isActive;
  ChangeDoctorStatusEvent({required this.isActive, required this.doctorId});
}

// class UpdateDoctorEvent extends AdminDocDetailsEvent {
//   final String doctorId;

//   UpdateDoctorEvent({required this.doctorId});
// }
