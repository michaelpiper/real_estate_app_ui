part of 'search_bloc.dart';

class SearchState {}

class SearchLoading extends SearchState {}

class SearchInitial extends SearchState {}

class SearchLoaded extends SearchState {
  List<Property> properties;
  SearchFilters? filters;
  SearchLoaded({
    required this.properties,
    this.filters,
  });
}

class SearchError extends SearchState {
  String message;
  SearchFilters? filters;
  SearchError({
    required this.message,
    this.filters,
  });
}
