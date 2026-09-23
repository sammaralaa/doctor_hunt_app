import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';
import 'package:doctor_hunt_app/features/patient/home/data/repos/home_repository.dart';
import 'package:doctor_hunt_app/features/patient/home/presentation/controller/home_event.dart';
import 'package:doctor_hunt_app/features/patient/home/presentation/controller/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent,HomeState>{
  final HomeRepository _homeRepository;

  HomeBloc(this._homeRepository) : super(HomeInitialState()) {
    on<FetchDoctorsDataEvent>(_onFetchDoctorsData);
    on<GetUserProfileDataEvent>(_onGetUserProfileData);
  }

  Future<void> _onGetUserProfileData(
    GetUserProfileDataEvent event,
    Emitter<HomeState> emit
  )async{
     emit(UserProfileLoadingState());
    try{
        final user = await _homeRepository.getUserProfileData();
        if(user != null ){
          emit(UserProfileSuccessState(user));
        }else {
        emit(UserProfileFailureState('User not found'));
      }
    }catch(e){
        emit(UserProfileFailureState(e.toString()));
    }
  }
  Future<void> _onFetchDoctorsData(
    FetchDoctorsDataEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(FetchDoctorsLoadingState());
    try {
      
      await emit.forEach<List<DoctorModel>>(
      _homeRepository.getDoctors(),
      onData: (doctors) {
       // final activeCount = doctors.where((d) => d.isActive).length;
        return FetchDoctorsSuccessState( doctorsData: doctors,);
      },
      onError: (error, stackTrace) {
        return FetchDoctorsFailureState(error.toString());
      },
    );
    } catch (e) {
      emit(FetchDoctorsFailureState(e.toString()));
    }
  }
  
}