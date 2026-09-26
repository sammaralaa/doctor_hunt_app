import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';
import 'package:equatable/equatable.dart';


abstract class DoctorDetailsState  extends Equatable{
  const DoctorDetailsState();

  @override
  List<Object?> get props => [];
}

class DoctorDetailsInitialState extends DoctorDetailsState {}

class DoctorDetailsLoadingState extends DoctorDetailsState {}

class DoctorDetailsSuccessState extends DoctorDetailsState {
  final DoctorModel doctorData;
 const DoctorDetailsSuccessState({required this.doctorData});
 @override
  List<Object?> get props => [doctorData];
}
class DoctorDetailsFailureState extends DoctorDetailsState{
  final String errorMessage;
  const DoctorDetailsFailureState(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}

