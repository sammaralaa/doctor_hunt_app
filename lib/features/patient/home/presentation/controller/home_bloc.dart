import 'package:doctor_hunt_app/features/patient/home/data/patient_model.dart';
import 'package:doctor_hunt_app/features/patient/home/data/repos/home_repository.dart';
import 'package:doctor_hunt_app/features/patient/home/presentation/controller/home_event.dart';
import 'package:doctor_hunt_app/features/patient/home/presentation/controller/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent,HomeState>{
  final HomeRepository _homeRepository;

  HomeBloc(this._homeRepository) : super(HomeInitialState()) {
    on<UploadProfileImageEvent>(_onUploadProfileImage);
    on<GetUserProfileDataEvent>(_onGetUserProfileData);
  }

  Future<void> _onGetUserProfileData(
    GetUserProfileDataEvent event,
    Emitter<HomeState> emit
  )async{
     emit(ProfileImageLoadingState());
    try{
        final user = await _homeRepository.getUserProfileData();
        if(user != null ){
          emit(UserProfileSuccessState(user));
        }else {
        emit(UserProfileFailureState('User not found'));
      }
    }catch(e){
        emit(UserProfileFailureState('User not found'));
    }
  }

  Future<void> _onUploadProfileImage(
    UploadProfileImageEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(ProfileImageLoadingState());

    try {
      final PatientModel? imageUrl = await _homeRepository.uploadOrUpdateProfileImage(
        imageFile: event.imageFile,
      );

      if (imageUrl != null) {
        emit(ProfileImageSuccessState(imageUrl));
      } else {
        emit( ProfileImageFailureState("Failed to upload image"));
      }
    } catch (e) {
      emit(ProfileImageFailureState(e.toString()));
    }
  }
}