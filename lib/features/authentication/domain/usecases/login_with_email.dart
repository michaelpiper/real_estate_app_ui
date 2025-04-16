import 'package:real_estate_app/core/errors/failures.dart';
import 'package:real_estate_app/features/authentication/domain/entities/user_entity.dart';
import 'package:real_estate_app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:result_library/result_library.dart';

class LoginWithEmail {
  final AuthRepository repository;

  LoginWithEmail(this.repository);

  Future<Result<UserEntity, Failure>> call(
      String email, String password) async {
    return await repository.loginWithEmail(email, password);
  }
}
