import 'package:real_estate_app/features/property/domain/entities/property_filters.dart';

class PropertyFiltersModel {
  final double? minPrice;
  final double? maxPrice;
  final int? minBedrooms;
  final int? maxBedrooms;
  // Include all other filter fields...

  PropertyFiltersModel({
    this.minPrice,
    this.maxPrice,
    this.minBedrooms,
    this.maxBedrooms,
    // ...
  });

  // Convert entity to model
  factory PropertyFiltersModel.fromEntity(PropertyFilters filters) {
    return PropertyFiltersModel(
      minPrice: filters.minPrice,
      maxPrice: filters.maxPrice,
      minBedrooms: filters.minBedrooms,
      maxBedrooms: filters.maxBedrooms,
      // ...
    );
  }

  // Convert model to JSON for API requests
  Map<String, dynamic> toJson() {
    return {
      'min_price': minPrice,
      'max_price': maxPrice,
      'min_bedrooms': minBedrooms,
      'max_bedrooms': maxBedrooms,
      // ...
    };
  }
}
