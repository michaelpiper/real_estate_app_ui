part of 'home_bloc.dart';

class HomeState {
  final List<Property> properties;

  const HomeState({
    required this.properties,
  });
}

class HomeInitial extends HomeState {
  HomeInitial({
    List<Property>? properties,
  }) : super(properties: properties ?? []);
}

class HomeLoading extends HomeInitial {
  HomeLoading({
    super.properties,
  });
}

class HomeLoaded extends HomeState {
  const HomeLoaded({
    required super.properties,
  });
}

class HomeError extends HomeInitial {
  HomeError(
    this.message, {
    super.properties,
  });
  final String message;
}
