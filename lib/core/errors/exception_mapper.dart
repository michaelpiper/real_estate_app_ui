import 'package:real_estate_app/core/errors/failures.dart';
import 'package:dio/dio.dart';

Failure mapExceptionToFailure(dynamic exception, StackTrace stackTrace) {
  if (exception is DioException) {
    return _handleDioException(exception, stackTrace);
  } else if (exception is FormatException) {
    return const ServerFailure(message: 'Data format error');
  } else if (exception is TypeError) {
    return const ServerFailure(message: 'Type conversion error');
  } else {
    return UnexpectedFailure(
      message: exception.toString(),
      stackTrace: stackTrace,
    );
  }
}

Failure _handleDioException(DioException exception, StackTrace stackTrace) {
  switch (exception.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return ServerFailure(
        message: 'Connection timeout',
        stackTrace: stackTrace,
      );
    case DioExceptionType.connectionError:
      return const NetworkFailure();
    case DioExceptionType.badResponse:
      return _handleBadResponse(exception, stackTrace);
    case DioExceptionType.cancel:
      return ServerFailure(
        message: 'Request cancelled',
        stackTrace: stackTrace,
      );
    case DioExceptionType.unknown:
      return const NetworkFailure();
    case DioExceptionType.badCertificate:
      return ServerFailure(
        message: 'Invalid certificate',
        stackTrace: stackTrace,
      );
  }
}

Failure _handleBadResponse(DioException exception, StackTrace stackTrace) {
  final statusCode = exception.response?.statusCode;
  final data = exception.response?.data;

  if (statusCode == 401) {
    return const AuthFailure(message: 'Unauthorized');
  } else if (statusCode == 403) {
    return const AuthFailure(message: 'Forbidden');
  } else if (statusCode == 404) {
    return const PropertyNotFoundFailure();
  } else if (statusCode == 422 && data != null) {
    try {
      final errors = Map<String, List<String>>.from(
        data['errors'] ?? {},
      );
      return ValidationFailure(
        errors: errors,
        stackTrace: stackTrace,
      );
    } catch (_) {
      return ServerFailure(
        message: data['message'] ?? 'Validation failed',
        stackTrace: stackTrace,
      );
    }
  } else {
    return ServerFailure(
      message: data?['message'] ?? 'Server error occurred',
      code: statusCode?.toString(),
      stackTrace: stackTrace,
    );
  }
}
