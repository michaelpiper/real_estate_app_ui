import 'package:bloc/bloc.dart';
import 'package:real_estate_app/features/favorites/domain/usecases/toggle_favorite.dart';

class FavoritesEvent {}

class LoadFavoritesEvent extends FavoritesEvent {}

class ToggleFavoriteEvent extends FavoritesEvent {}

class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final GetFavorites getFavorites;
  final ToggleFavorite toggleFavorite;

  FavoritesBloc({
    required this.getFavorites,
    required this.toggleFavorite,
  }) : super(FavoritesInitial()) {
    on<LoadFavoritesEvent>(_onLoadFavorites);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
  }

  _onLoadFavorites(event, state) {}
  _onToggleFavorite(event, state) {}
}
