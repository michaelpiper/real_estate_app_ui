import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_app/features/property/presentation/bloc/property_bloc.dart';
import 'package:real_estate_app/features/property/presentation/widgets/property_list.dart';

class PropertyPage extends StatelessWidget {
  const PropertyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Featured Properties')),
      body: BlocBuilder<PropertyBloc, PropertyState>(
        builder: (context, state) {
          if (state is PropertyInitial) {
            context.read<PropertyBloc>().add(FetchFeaturedProperties());
            return const Center(child: Text('Initializing...'));
          } else if (state is PropertyLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PropertyLoaded) {
            return PropertyList(properties: state.properties);
          } else if (state is PropertyError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
