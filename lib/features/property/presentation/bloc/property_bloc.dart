import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:real_estate_app/features/property/domain/entities/property_filters.dart';
import 'package:real_estate_app/features/property/domain/entities/property.dart';
import 'package:real_estate_app/features/property/domain/usecases/get_featured_properties.dart';
import 'package:real_estate_app/features/property/domain/usecases/get_filtered_properties.dart';

part "property_event.dart";
part "property_state.dart";

class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
  final GetFeaturedProperties getFeaturedProperties;
  final GetFilteredProperties getFilteredProperties;

  PropertyBloc({
    required this.getFeaturedProperties,
    required this.getFilteredProperties,
  }) : super(const PropertyLoading(filters: PropertyFilters())) {
    on<LoadProperties>(_onLoadProperties);
    on<FetchFeaturedProperties>(_onFetchFeaturedProperties);
  }
  Future<void> _onLoadProperties(
    LoadProperties event,
    Emitter<PropertyState> emit,
  ) async {
    emit(PropertyLoading(filters: event.filters));
    final result = await getFilteredProperties(event.filters);
    if (result.isErr()) {
      emit(PropertyError(
        message: result.err().toString(),
        filters: event.filters,
      ));
    } else {
      emit(PropertyLoaded(
        properties: result.ok(),
        filters: event.filters,
      ));
    }
  }

  Future<void> _onFetchFeaturedProperties(
    FetchFeaturedProperties event,
    Emitter<PropertyState> emit,
  ) async {
    emit(const PropertyLoading(filters: PropertyFilters()));
    final result = await getFeaturedProperties();
    if (result.isErr()) {
      emit(PropertyError(
        message: result.err().toString(),
        filters: null,
      ));
    } else {
      emit(PropertyLoaded(
        properties: result.ok(),
        filters: null,
      ));
    }
  }
}
