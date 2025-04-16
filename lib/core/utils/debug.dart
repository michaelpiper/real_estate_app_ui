import 'package:flutter/foundation.dart';

class Debug {
  Debug();
  log([input, input2, input3]) {
    if (kDebugMode) {
      if (input != null) {
        debugPrint(input.toString());
      }
      if (input2 != null) {
        debugPrint(input2.toString());
      }
      if (input3 != null) {
        debugPrint(input3.toString());
      }
    }
  }
}

final debug = Debug();
