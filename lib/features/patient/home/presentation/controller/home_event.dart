
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}
class FetchDoctorsDataEvent extends HomeEvent {

  const FetchDoctorsDataEvent();

  @override
  List<Object?> get props => [];
}

class GetUserProfileDataEvent extends HomeEvent{
  
  const GetUserProfileDataEvent();

  @override
    List<Object?> get props => [];

}