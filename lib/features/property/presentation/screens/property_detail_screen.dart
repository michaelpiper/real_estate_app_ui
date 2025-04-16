// lib/features/property/presentation/screens/property_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_app/features/property/presentation/bloc/property_detail_bloc.dart';
import 'package:real_estate_app/features/property/presentation/screens/property_detail_view.dart';
import 'package:real_estate_app/injection.dart';

class PropertyDetailScreen extends StatelessWidget {
  final String propertyId;

  const PropertyDetailScreen({super.key, required this.propertyId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Property Details')),
      body: BlocProvider(
        create: (_) => PropertyDetailBloc(
            getPropertyDetails: getIt(), propertyId: propertyId),
        child: PropertyDetailView(propertyId: propertyId),
      ),
    );
  }
}
