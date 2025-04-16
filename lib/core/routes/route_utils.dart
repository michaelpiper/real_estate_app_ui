import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteUtils {
  static void goToPropertyDetails(BuildContext context, String propertyId) {
    context.goNamed(
      'property-details',
      pathParameters: {'id': propertyId},
      extra: propertyId,
    );
  }

  static void goToLogin(BuildContext context) {
    context.goNamed('login');
  }

  static Future<T?> showDialog<T>({
    required BuildContext context,
    required Widget dialog,
  }) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (_, __, ___) => dialog,
    );
  }
}
