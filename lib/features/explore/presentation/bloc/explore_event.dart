part of 'explore_bloc.dart';

class ExploreEvent extends Equatable {
  const ExploreEvent();
  @override
  List<Object?> get props => [];
}

class LoadExploreData extends ExploreEvent {}

class SearchProperties extends ExploreEvent {
  final String query;

  const SearchProperties({required this.query});

  @override
  List<Object> get props => [query];
}
