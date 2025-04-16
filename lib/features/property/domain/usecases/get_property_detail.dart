import 'package:real_estate_app/core/errors/failures.dart';
import 'package:real_estate_app/features/property/domain/entities/property.dart';
import 'package:real_estate_app/features/property/domain/repositories/property_repository.dart';
import 'package:result_library/result_library.dart';

class GetPropertyDetail {
  final PropertyRepository repository;

  GetPropertyDetail(this.repository);

  Future<Result<Property, Failure>> call(String propertyId) async {
    return await repository.getPropertyDetails(propertyId);
  }
}
