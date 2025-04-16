import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_estate_app/features/property/presentation/screens/property_detail_screen.dart';

class PropertyDetailPage extends StatelessWidget {
  const PropertyDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final propertyId = GoRouterState.of(context).pathParameters['id']!;
    return PropertyDetailScreen(propertyId: propertyId);
  }
}
