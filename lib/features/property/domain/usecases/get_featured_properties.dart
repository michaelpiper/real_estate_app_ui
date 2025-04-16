import 'package:real_estate_app/core/errors/failures.dart';
import 'package:real_estate_app/features/property/domain/entities/property.dart';
import 'package:real_estate_app/features/property/domain/repositories/property_repository.dart';
import 'package:result_library/result_library.dart';

class GetFeaturedProperties {
  final PropertyRepository repository;

  GetFeaturedProperties({required this.repository});

  Future<Result<List<Property>, Failure>> call() async {
    return await repository.getFeaturedProperties();
  }
}
