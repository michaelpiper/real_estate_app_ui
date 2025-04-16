import 'package:real_estate_app/core/errors/failures.dart';

extension FailureExtensions on Failure {
  String get formattedMessage {
    if (this is ValidationFailure) {
      final errors = (this as ValidationFailure).errors;
      return errors.entries
          .map((e) => '${e.key}: ${e.value.join(', ')}')
          .join('\n');
    }
    return message;
  }

  bool get shouldRetry {
    return this is NetworkFailure ||
        this is ServerFailure ||
        this is UnexpectedFailure;
  }
}
