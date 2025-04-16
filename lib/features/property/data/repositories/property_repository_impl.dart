import 'package:real_estate_app/core/errors/failures.dart';
import 'package:real_estate_app/features/property/domain/datasources/property_remote_data_source.dart';
import 'package:real_estate_app/features/property/domain/entities/property.dart';
import 'package:real_estate_app/features/property/domain/entities/property_filters.dart';
import 'package:real_estate_app/features/property/domain/repositories/property_repository.dart';
import 'package:result_library/result_library.dart';

class PropertyRepositoryImpl implements PropertyRepository {
  final PropertyRemoteDataSource remoteDataSource;

  PropertyRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<List<Property>, Failure>> getFeaturedProperties() async {
    final properties = await remoteDataSource.getFeaturedProperties();
    return Ok(properties);
  }

  @override
  Future<Result<Property, Failure>> getPropertyDetails(String id) {
    // TODO: implement getPropertyDetails
    throw UnimplementedError();
  }

  @override
  Future<Result<List<Property>, Failure>> searchProperties(String query) {
    // TODO: implement searchProperties
    throw UnimplementedError();
  }

  @override
  Future<Result<List<Property>, Failure>> filterProperties({
    required PropertyFilters filters,
  }) {
    // TODO: implement filterProperties
    throw UnimplementedError();
  }
}
