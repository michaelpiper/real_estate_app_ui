part of 'home_bloc.dart';

class HomeEvent {}

class LoadHomeData extends HomeEvent {}

class PreCachePropertyImages extends HomeEvent {
  BuildContext context;
  PreCachePropertyImages(this.context);
}
