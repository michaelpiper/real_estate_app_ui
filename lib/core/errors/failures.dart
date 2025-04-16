import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final String? code;
  final StackTrace? stackTrace;

  const Failure({
    required this.message,
    this.code,
    this.stackTrace,
  });

  @override
  List<Object?> get props => [message, code, stackTrace];

  @override
  String toString() => 'Failure(message: $message, code: $code)';
}

// Server/API Failures
class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.code = 'SERVER_FAILURE',
    super.stackTrace,
  });
}

class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'No internet connection',
    super.code = 'NETWORK_FAILURE',
    super.stackTrace,
  });
}

// Authentication Failures
class AuthFailure extends Failure {
  const AuthFailure({
    required super.message,
    super.code = 'AUTH_FAILURE',
    super.stackTrace,
  });
}

class InvalidCredentialsFailure extends AuthFailure {
  const InvalidCredentialsFailure({
    super.message = 'Invalid email or password',
    super.code = 'INVALID_CREDENTIALS',
    super.stackTrace,
  });
}

class EmailAlreadyInUseFailure extends AuthFailure {
  const EmailAlreadyInUseFailure({
    super.message = 'Email already in use',
    super.code = 'EMAIL_IN_USE',
    super.stackTrace,
  });
}

// Property-related Failures
class PropertyFailure extends Failure {
  const PropertyFailure({
    required super.message,
    super.code = 'PROPERTY_FAILURE',
    super.stackTrace,
  });
}

class PropertyNotFoundFailure extends PropertyFailure {
  const PropertyNotFoundFailure({
    super.message = 'Property not found',
    super.code = 'PROPERTY_NOT_FOUND',
    super.stackTrace,
  });
}

// Location-related Failures
class LocationFailure extends Failure {
  const LocationFailure({
    required super.message,
    super.code = 'LOCATION_FAILURE',
    super.stackTrace,
  });
}

class PermissionDeniedFailure extends LocationFailure {
  const PermissionDeniedFailure({
    super.message = 'Location permission denied',
    super.code = 'PERMISSION_DENIED',
    super.stackTrace,
  });
}

// General Failures
class UnexpectedFailure extends Failure {
  const UnexpectedFailure({
    super.message = 'Unexpected error occurred',
    super.code = 'UNEXPECTED_ERROR',
    super.stackTrace,
  });
}

class ValidationFailure extends Failure {
  final Map<String, List<String>> errors;

  const ValidationFailure({
    required this.errors,
    super.message = 'Validation failed',
    super.code = 'VALIDATION_FAILURE',
    super.stackTrace,
  });

  @override
  List<Object?> get props => [errors, ...super.props];
}
