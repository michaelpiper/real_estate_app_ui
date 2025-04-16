import 'package:real_estate_app/features/property/data/models/property_model.dart';
import 'package:real_estate_app/features/property/domain/datasources/property_remote_data_source.dart';
import 'package:real_estate_app/features/property/domain/entities/property.dart';

class PropertyRemoteDataSourceImpl extends PropertyRemoteDataSource {
  PropertyRemoteDataSourceImpl({required client});

  @override
  Future<List<PropertyModel>> getFeaturedProperties() async {
    return <PropertyModel>[
      PropertyModel(
        id: "001",
        title: "title",
        price: 10300000,
        location: 'Gladkova St., 25',
        latlng: "37.42796133580664,-122.085749655962",
        imageUrl:
            'https://media.istockphoto.com/id/2027568389/photo/a-grey-and-white-modern-farmhouse.jpg?s=1024x1024&w=is&k=20&c=dXtTEUsiWo-cQXF3hcHPXHaIlwgAyLKv-hTeCoxZC2I=',
        images: [],
        bedrooms: 1,
        bathrooms: 2,
        area: 3,
        status: PropertyStatus.forRent,
        isFeatured: true,
        createdAt: DateTime.now(),
      ),
      PropertyModel(
        id: "002",
        title: "title",
        price: 11300000,
        location: 'Treteleva St., 43',
        latlng: "37.42796133580664,-122.075749655962",
        imageUrl:
            'https://media.istockphoto.com/id/1145727455/photo/modern-suburban-house-exterior.jpg?s=1024x1024&w=is&k=20&c=DGbIAf3DUgXKzV3BEAXppRj6weLxrBFyu2AwRnRH6OI=',
        images: [],
        bedrooms: 1,
        bathrooms: 2,
        area: 3,
        status: PropertyStatus.forRent,
        isFeatured: false,
        createdAt: DateTime.now(),
      ),
      PropertyModel(
        id: "003",
        title: "title",
        price: 15300000,
        location: 'New York St., 44',
        latlng: "37.42565212395061, -122.08655197173357",
        imageUrl:
            'https://media.istockphoto.com/id/1147230721/photo/modern-suburban-house-exterior.jpg?s=612x612&w=0&k=20&c=NYsR24QGQVK4ZCspLYg5CVFBXTtK-NkYy2PkiwyMiKs=',
        images: const [],
        bedrooms: 1,
        bathrooms: 2,
        area: 3,
        status: PropertyStatus.forRent,
        isFeatured: false,
        createdAt: DateTime.now(),
      ),
      PropertyModel(
        id: "004",
        title: "title",
        price: 15300000,
        location: 'New York St., 44',
        latlng: "37.42161715576491, -122.08045799285175",
        imageUrl:
            'https://media.istockphoto.com/id/1147230721/photo/modern-suburban-house-exterior.jpg?s=612x612&w=0&k=20&c=NYsR24QGQVK4ZCspLYg5CVFBXTtK-NkYy2PkiwyMiKs=',
        images: const [],
        bedrooms: 1,
        bathrooms: 2,
        area: 3,
        status: PropertyStatus.forRent,
        isFeatured: false,
        createdAt: DateTime.now(),
      ),
      PropertyModel(
        id: "005",
        title: "title",
        price: 15300000,
        location: 'Treteleva St., 43',
        latlng: "37.416344796305715, -122.08248507231474",
        imageUrl:
            'https://media.istockphoto.com/id/1147230721/photo/modern-suburban-house-exterior.jpg?s=612x612&w=0&k=20&c=NYsR24QGQVK4ZCspLYg5CVFBXTtK-NkYy2PkiwyMiKs=',
        images: const [],
        bedrooms: 1,
        bathrooms: 2,
        area: 3,
        status: PropertyStatus.forRent,
        isFeatured: false,
        createdAt: DateTime.now(),
      ),
    ];
  }
}
