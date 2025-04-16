import 'package:real_estate_app/core/utils/number_formatter.dart';

class FormatNumberUseCase {
  String call(double number) {
    return NumberFormatter.format(number);
  }
}
