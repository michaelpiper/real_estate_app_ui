import 'package:real_estate_app/core/errors/failures.dart';
import 'package:real_estate_app/features/authentication/domain/entities/user_entity.dart';
import 'package:real_estate_app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:result_library/result_library.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Result<UserEntity, Failure>> getUser(String id) async {
    return Ok(UserEntity(id: id, email: "email"));
  }

  @override
  Future<Result<UserEntity, Failure>> loginWithEmail(email, password) async {
    // TODO: implement loginWithEmail
    return Ok(const UserEntity(id: "id", email: "email"));
  }
}
