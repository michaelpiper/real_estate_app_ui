import 'package:real_estate_app/core/errors/failures.dart';
import 'package:real_estate_app/features/property/domain/entities/property.dart';
import 'package:real_estate_app/features/property/domain/repositories/property_repository.dart';
import 'package:result_library/result_library.dart';

class GetSearchProperties {
  final PropertyRepository repository;

  GetSearchProperties({required this.repository});

  Future<Result<List<Property>, Failure>> call(String query) async {
    return await repository.searchProperties(query);
  }
}
