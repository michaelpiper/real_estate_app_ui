import 'package:real_estate_app/core/errors/failures.dart';
import 'package:real_estate_app/features/favorites/domain/entities/favorite.dart';
import 'package:result_library/result_library.dart';

abstract class FavoritesRepository {
  Future<Result<void, Failure>> toggleFavorite(String propertyId);
  Future<Result<List<Favorite>, Failure>> getFavorites();
}
