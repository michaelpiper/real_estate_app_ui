import 'package:flutter/material.dart';
import 'package:real_estate_app/features/property/domain/entities/property.dart';

class PropertyModel extends Property {
  PropertyModel({
    required super.id,
    required super.title,
    required super.price,
    required super.location,
    required super.latlng,
    required super.imageUrl,
    required super.images,
    required super.bedrooms,
    required super.bathrooms,
    required super.area,
    required super.status,
    required super.isFeatured,
    required super.createdAt,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    try {
      // Validate required fields
      if (json['id'] == null) {
        throw const FormatException('Missing property id');
      }
      if (json['title'] == null) {
        throw const FormatException('Missing property title');
      }
      if (json['price'] == null) {
        throw const FormatException('Missing property price');
      }
      if (json['location'] == null) {
        throw const FormatException('Missing property location');
      }

      // Parse with type safety
      return PropertyModel(
        id: json['id'].toString(), // Ensure String type
        title: json['title'].toString(),
        price: _parsePrice(json['price']),
        location: json['location'].toString(),
        bedrooms: json['bedrooms'] != null
            ? int.tryParse(json['bedrooms'].toString()) ?? 0
            : 0,
        bathrooms: json['bathrooms'] != null
            ? double.tryParse(json['bathrooms'].toString()) ?? 0.0
            : 0.0,
        area: json['area'] != null
            ? int.tryParse(json['area'].toString()) ?? 0
            : 0,
        status: _parseStatus(json['status']),
        images: json['images'] != null
            ? List<String>.from(json['images'].map((x) => x.toString()))
            : <String>[],
        isFeatured: json['is_featured'] == true,
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'].toString())
            : DateTime.now(),
        imageUrl: json['imageUrl'].toString(),
        latlng: json['latlng'].toString(),
      );
    } catch (e, stackTrace) {
      // Log error for debugging
      debugPrint('Error parsing PropertyModel: $e');
      debugPrint(stackTrace.toString());
      throw const FormatException('Invalid property data format');
    }
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'location': location,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'area': area,
      'status': status.name,
      'images': images,
      'imageUrl': imageUrl,
      'is_featured': isFeatured,
      'created_at': createdAt.toIso8601String(),
    };
  }

  static double _parsePrice(dynamic price) {
    if (price is double) return price;
    if (price is int) return price.toDouble();
    if (price is String) return double.tryParse(price) ?? 0.0;
    return 0.0;
  }

  static PropertyStatus _parseStatus(dynamic status) {
    if (status is PropertyStatus) return status;
    if (status is String) {
      switch (status.toLowerCase()) {
        case 'for_rent':
        case 'rent':
          return PropertyStatus.forRent;
        case 'for_sale':
        case 'sale':
          return PropertyStatus.forSale;
        default:
          return PropertyStatus.forSale;
      }
    }
    return PropertyStatus.forSale;
  }
}
