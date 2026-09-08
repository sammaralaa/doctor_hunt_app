import 'package:doctor_hunt_app/features/home/data/repos/home_repository.dart';
import 'package:doctor_hunt_app/features/home/presentation/controller/home_event.dart';
import 'package:doctor_hunt_app/features/home/presentation/controller/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent,HomeState>{
  final HomeRepository _homeRepository;

  HomeBloc(this._homeRepository) : super(HomeInitialState()) {
    on<UploadProfileImageEvent>(_onUploadProfileImage);
  }
  Future<void> _onUploadProfileImage(
    UploadProfileImageEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(ProfileImageLoadingState());

    try {
      final String? imageUrl = await _homeRepository.uploadOrUpdateProfileImage(
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