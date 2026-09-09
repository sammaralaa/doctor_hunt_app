import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {

  @override
  List<Object?> get props => [];
}
class HomeInitialState extends HomeState {}
class ProfileImageLoadingState extends HomeState {}
class ProfileImageSuccessState extends HomeState {
  final String imageUrl;

   ProfileImageSuccessState( this.imageUrl);

  @override
  List<Object?> get props => [imageUrl];
}
class ProfileImageFailureState extends HomeState {
  final String errorMessage;

   ProfileImageFailureState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}