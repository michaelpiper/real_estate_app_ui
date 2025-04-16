part of 'explore_bloc.dart';

abstract class ExploreState extends Equatable {
  final List<Property> properties;
  final CameraPosition cameraPosition;
  final Set<Marker> markers;
  const ExploreState({
    required this.properties,
    required this.cameraPosition,
    this.markers = const <Marker>{},
  });
  @override
  List<Object?> get props => [markers, cameraPosition, properties];
}

class ExploreInitial extends ExploreState {
  ExploreInitial({
    Set<Marker>? markers,
    List<Property>? properties,
    CameraPosition? cameraPosition,
  }) : super(
          markers: markers ?? {},
          properties: properties ?? [],
          cameraPosition: cameraPosition ??
              const CameraPosition(
                target: LatLng(
                  37.42796133580664,
                  -122.085749655962,
                ),
                zoom: 15.4746,
              ),
        );
}

class ExploreLoading extends ExploreInitial {
  ExploreLoading({
    super.properties,
    super.cameraPosition,
    super.markers,
  });
}

class ExploreLoaded extends ExploreState {
  const ExploreLoaded({
    required super.properties,
    required super.cameraPosition,
    super.markers,
  });
}

class ExploreError extends ExploreInitial {
  ExploreError(
    this.message, {
    super.properties,
    super.cameraPosition,
    super.markers,
  });
  final String message;
}
