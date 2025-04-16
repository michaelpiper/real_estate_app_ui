import 'package:intl/intl.dart';

class NumberFormatter {
  static String format(double number) {
    final format = NumberFormat("##0.0", "fr_FR");

    if (number >= 1e9) {
      return "${format.format(number / 1e9)} bn";
    } else if (number >= 1e6) {
      return "${format.format(number / 1e6)} mn";
    } else if (number >= 1e3) {
      return "${format.format(number / 1e3)} k";
    } else {
      return NumberFormat.decimalPattern("fr_FR").format(number);
    }
  }
}
