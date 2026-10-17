import 'package:equatable/equatable.dart';

abstract class PopularDoctorsEvent extends Equatable {
  const PopularDoctorsEvent();

  @override
  List<Object?> get props => [];
}

class FetchPopularDoctorsEvent extends PopularDoctorsEvent {
  const FetchPopularDoctorsEvent();
}
