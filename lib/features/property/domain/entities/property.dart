class Property {
  final String id;
  final String title;
  final double price;
  final String location;
  final String latlng;
  final String? imageUrl;
  final List<String> images;
  // other properties
  final int bedrooms;
  final double bathrooms;
  final int area;
  final PropertyStatus status;
  final bool isFeatured;
  final DateTime createdAt;
  const Property({
    required this.id,
    required this.title,
    required this.price,
    required this.location,
    required this.imageUrl,
    required this.images,
    required this.bedrooms,
    required this.bathrooms,
    required this.latlng,
    required this.area,
    required this.status,
    required this.isFeatured,
    required this.createdAt,
  });

  String get formattedPrice => '\$${price.toStringAsFixed(0)}';

  double get latitude {
    final array = latlng.split(',');
    if (array.isEmpty) {
      throw Exception("invalid latlng provided");
    }
    return double.parse(array.elementAt(0).trim());
  }

  double get longitude {
    final array = latlng.split(',');
    if (array.length <= 1) {
      throw Exception("invalid latlng provided");
    }
    return double.parse(array.elementAt(1).trim());
  }
}

enum PropertyStatus { forSale, forRent }

extension PropertyStatusX on PropertyStatus {
  String get displayName {
    switch (this) {
      case PropertyStatus.forSale:
        return 'For Sale';
      case PropertyStatus.forRent:
        return 'For Rent';
    }
  }
}
