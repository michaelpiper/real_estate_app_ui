import 'package:real_estate_app/core/errors/failures.dart';
import 'package:real_estate_app/features/property/domain/entities/property_filters.dart';
import 'package:real_estate_app/features/property/domain/entities/property.dart';
import 'package:result_library/result_library.dart';

abstract class PropertyRepository {
  Future<Result<List<Property>, Failure>> getFeaturedProperties();
  Future<Result<Property, Failure>> getPropertyDetails(String id);
  Future<Result<List<Property>, Failure>> filterProperties({
    required PropertyFilters filters,
  });
  Future<Result<List<Property>, Failure>> searchProperties(String query);
}
