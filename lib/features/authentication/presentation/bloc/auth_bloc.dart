import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_app/features/authentication/domain/usecases/login_with_email.dart';
import 'package:real_estate_app/features/authentication/domain/usecases/register_with_email.dart';
import 'package:real_estate_app/features/authentication/domain/usecases/logout.dart';

class AuthState {}

class AuthEvent {}

class AuthInitial extends AuthState {}

class AuthAuthenticated extends AuthState {}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginWithEmail loginWithEmail;
  final RegisterWithEmail registerWithEmail;
  final Logout logout;
  AuthBloc({
    required this.loginWithEmail,
    required this.registerWithEmail,
    required this.logout,
  }) : super(AuthInitial());
}
