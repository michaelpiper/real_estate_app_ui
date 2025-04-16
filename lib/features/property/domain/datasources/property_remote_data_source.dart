import 'package:real_estate_app/features/property/data/models/property_model.dart';

abstract class PropertyRemoteDataSource {
  Future<List<PropertyModel>> getFeaturedProperties();
}
