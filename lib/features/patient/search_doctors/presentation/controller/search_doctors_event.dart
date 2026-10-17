import 'package:equatable/equatable.dart';

abstract class SearchDoctorsEvent extends Equatable {
  const SearchDoctorsEvent();

  @override
  List<Object?> get props => [];
}

class SearchQueryChangedEvent extends SearchDoctorsEvent {
  final String query;

  const SearchQueryChangedEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class ClearSearchEvent extends SearchDoctorsEvent {
  const ClearSearchEvent();
}
