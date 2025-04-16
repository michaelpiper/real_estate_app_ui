import 'package:real_estate_app/core/errors/failures.dart';
import 'package:real_estate_app/features/property/domain/entities/property_filters.dart';
import 'package:real_estate_app/features/property/domain/entities/property.dart';
import 'package:real_estate_app/features/property/domain/repositories/property_repository.dart';
import 'package:real_estate_app/features/search/domain/entities/search_filters.dart';
import 'package:result_library/result_library.dart';

class GetSearchedFilteredProperties {
  final PropertyRepository repository;

  GetSearchedFilteredProperties(this.repository);

  Future<Result<List<Property>, Failure>> call(SearchFilters filters) async {
    return await repository.filterProperties(
        filters: PropertyFilters(
      minBedrooms: filters.bedrooms,
    ));
  }
}
