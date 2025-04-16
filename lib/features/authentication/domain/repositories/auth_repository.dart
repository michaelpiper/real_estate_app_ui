import 'package:real_estate_app/core/errors/failures.dart';
import 'package:real_estate_app/features/authentication/domain/entities/user_entity.dart';
import 'package:result_library/result_library.dart';

abstract class AuthRepository {
  Future<Result<UserEntity, Failure>> getUser(String id);
  Future<Result<UserEntity, Failure>> loginWithEmail(email, password);
}
