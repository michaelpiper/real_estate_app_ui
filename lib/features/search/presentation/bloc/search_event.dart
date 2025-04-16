part of 'search_bloc.dart';

class SearchEvent {}

class SearchWithFilters extends SearchEvent {
  final SearchFilters filters;

  SearchWithFilters({required this.filters});
}
