
abstract class CreateDoctorState {}

class CreateDoctorInitialState extends CreateDoctorState {}

class CreateDoctorLoadingState extends CreateDoctorState {}

class CreateDoctorSuccessState extends CreateDoctorState {}

class CreateDoctorFailureState extends CreateDoctorState {
  final String errorMessage;

  CreateDoctorFailureState(this.errorMessage);
}
