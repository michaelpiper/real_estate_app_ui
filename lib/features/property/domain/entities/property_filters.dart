import 'package:equatable/equatable.dart';

enum PropertyType {
  all,
  apartment,
  house,
  villa,
  land,
  commercial,
}

class PropertyFilters extends Equatable {
  final double? minPrice;
  final double? maxPrice;
  final int? minBedrooms;
  final int? maxBedrooms;
  final int? minBathrooms;
  final double? minArea;
  final double? maxArea;
  final PropertyType? propertyType;
  final bool? hasParking;
  final bool? hasPool;
  final bool? isFurnished;
  final int? constructionYear;
  final String? location;

  const PropertyFilters({
    this.minPrice,
    this.maxPrice,
    this.minBedrooms,
    this.maxBedrooms,
    this.minBathrooms,
    this.minArea,
    this.maxArea,
    this.propertyType,
    this.hasParking,
    this.hasPool,
    this.isFurnished,
    this.constructionYear,
    this.location,
  });

  PropertyFilters copyWith({
    double? minPrice,
    double? maxPrice,
    int? minBedrooms,
    int? maxBedrooms,
    int? minBathrooms,
    double? minArea,
    double? maxArea,
    PropertyType? propertyType,
    bool? hasParking,
    bool? hasPool,
    bool? isFurnished,
    int? constructionYear,
    String? location,
  }) {
    return PropertyFilters(
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      minBedrooms: minBedrooms ?? this.minBedrooms,
      maxBedrooms: maxBedrooms ?? this.maxBedrooms,
      minBathrooms: minBathrooms ?? this.minBathrooms,
      minArea: minArea ?? this.minArea,
      maxArea: maxArea ?? this.maxArea,
      propertyType: propertyType ?? this.propertyType,
      hasParking: hasParking ?? this.hasParking,
      hasPool: hasPool ?? this.hasPool,
      isFurnished: isFurnished ?? this.isFurnished,
      constructionYear: constructionYear ?? this.constructionYear,
      location: location ?? this.location,
    );
  }

  bool get hasFilters {
    return minPrice != null ||
        maxPrice != null ||
        minBedrooms != null ||
        maxBedrooms != null ||
        minBathrooms != null ||
        minArea != null ||
        maxArea != null ||
        propertyType != null ||
        hasParking != null ||
        hasPool != null ||
        isFurnished != null ||
        constructionYear != null ||
        (location != null && location!.isNotEmpty);
  }

  @override
  List<Object?> get props => [
        minPrice,
        maxPrice,
        minBedrooms,
        maxBedrooms,
        minBathrooms,
        minArea,
        maxArea,
        propertyType,
        hasParking,
        hasPool,
        isFurnished,
        constructionYear,
        location,
      ];
}
