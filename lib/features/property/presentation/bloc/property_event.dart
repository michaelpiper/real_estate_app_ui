part of "property_bloc.dart";

abstract class PropertyEvent extends Equatable {
  const PropertyEvent();
}

class FetchFeaturedProperties extends PropertyEvent {
  @override
  List<Object> get props => [];
}

class LoadProperties extends PropertyEvent {
  final PropertyFilters filters;

  const LoadProperties({required this.filters});

  @override
  List<Object?> get props => [filters];
}
