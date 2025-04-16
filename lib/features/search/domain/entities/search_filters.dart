import 'package:real_estate_app/features/property/domain/entities/property_filters.dart';

class SearchFilters {
  final double? minPrice;
  final double? maxPrice;
  final int? bedrooms;
  final PropertyType? type;

  const SearchFilters({
    this.minPrice,
    this.maxPrice,
    this.bedrooms,
    this.type,
  });
}
