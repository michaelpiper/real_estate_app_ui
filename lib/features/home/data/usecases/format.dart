import 'package:intl/intl.dart';

abstract class FormatNumberUseCase {
  const FormatNumberUseCase();
  String call(num value);
}

class FormatWithSpaceSeparator extends FormatNumberUseCase {
  const FormatWithSpaceSeparator();
  @override
  String call(num value) {
    final formatter = NumberFormat('#,##0', 'en_US');
    return formatter.format(value).replaceAll(',', ' ');
  }
}
