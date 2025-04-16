import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_app/features/property/domain/entities/property.dart';
import 'package:real_estate_app/features/property/domain/usecases/get_featured_properties.dart';

part "home_event.dart";
part "home_state.dart";

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetFeaturedProperties getFeaturedProperties;

  HomeBloc({
    required this.getFeaturedProperties,
  }) : super(HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
    on<PreCachePropertyImages>(_onPreCachePropertyImages);
  }
  _onPreCachePropertyImages(
    PreCachePropertyImages event,
    Emitter<HomeState> emit,
  ) async {
    await Future.wait(
      state.properties
          .where(
            (property) => property.imageUrl != null,
          )
          .map(
            (property) => precacheImage(
              NetworkImage(property.imageUrl!),
              event.context,
            ),
          ),
    );
  }

  _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading(
      properties: state.properties,
    ));
    final result = await getFeaturedProperties();
    if (result.isErr()) {
      emit(HomeError(
        result.err().toString(),
        properties: state.properties,
      ));
      return;
    }
    emit(HomeLoaded(
      properties: result.ok(),
    ));
  }
}
