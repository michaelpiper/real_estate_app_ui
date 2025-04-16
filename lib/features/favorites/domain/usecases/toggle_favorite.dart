import 'package:real_estate_app/core/errors/failures.dart';
import 'package:real_estate_app/features/favorites/domain/entities/favorite.dart';
import 'package:real_estate_app/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:result_library/result_library.dart';

class ToggleFavorite {
  final FavoritesRepository repository;

  ToggleFavorite(this.repository);

  Future<Result<void, Failure>> call(String propertyId) async {
    return await repository.toggleFavorite(propertyId);
  }
}

class GetFavorites {
  final FavoritesRepository repository;

  GetFavorites(this.repository);

  Future<Result<List<Favorite>, Failure>> call() async {
    return await repository.getFavorites();
  }
}
