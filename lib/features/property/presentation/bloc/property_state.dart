part of "property_bloc.dart";

abstract class PropertyState extends Equatable {
  final PropertyFilters? filters;
  const PropertyState({required this.filters});

  @override
  List<Object?> get props => [filters];
}

class PropertyInitial extends PropertyState {
  const PropertyInitial({required super.filters});

  @override
  List<Object> get props => [];
}

class PropertyLoading extends PropertyState {
  const PropertyLoading({required super.filters});
}

class PropertyLoaded extends PropertyState {
  final List<Property> properties;

  const PropertyLoaded({required super.filters, required this.properties});

  @override
  List<Object?> get props => [filters, properties];
}

class PropertyError extends PropertyState {
  final String message;

  const PropertyError({required super.filters, required this.message});

  @override
  List<Object?> get props => [filters, message];
}
