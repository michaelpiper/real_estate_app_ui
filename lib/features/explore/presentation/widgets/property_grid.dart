// lib/features/explore/presentation/widgets/property_grid.dart
import 'package:flutter/material.dart';
import 'package:real_estate_app/core/presentation/widgets/lazy_widget.dart';
import 'package:real_estate_app/core/presentation/widgets/scale_in_widget.dart';

import 'package:real_estate_app/core/presentation/widgets/scroll_up.dart';
import 'package:real_estate_app/core/theme/app_colors.dart';
import 'package:real_estate_app/features/property/domain/entities/property.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// Usage:

class PropertyGrid extends StatelessWidget {
  final List<Property> properties;

  const PropertyGrid({super.key, required this.properties});

  @override
  Widget build(BuildContext context) {
    if (properties.isEmpty) {
      return const Center(
        child: Text('No properties found',
            style: TextStyle(color: AppColors.textSecondary)),
      );
    }
    return StaggeredGrid.count(
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,

      crossAxisCount: 2,
      // physics: const NeverScrollableScrollPhysics(),
      // shrinkWrap: true,
      children: properties
          .map(
            (property) => StaggeredGridTile.extent(
              crossAxisCellCount: property.isFeatured ? 2 : 1,
              mainAxisExtent: 200,
              child: LazyVisible.builder(
                key: ValueKey("property-${property.id}"),
                placeholder: const SizedBox.square(dimension: 30),
                builder: (context, child) => _PropertyCard(property: property),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _PropertyCardButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const _PropertyCardButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      style: IconButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: AppColors.background,
        fixedSize: Size.fromRadius(20),
      ),
      icon: const Icon(
        Icons.chevron_right,
        color: AppColors.secondary,
      ),
    );
  }
}

class _PropertyCard extends StatelessWidget {
  final Property property;

  const _PropertyCard({required this.property});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(30),
        ),
        // height: 100,
        child: GestureDetector(
          onTap: () {
            // Navigate to property details
          },
          child: Stack(
            // crossAxisAlignment: CrossAxisAlignment.start,
            fit: StackFit.expand,
            children: [
              if (property.imageUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    property.imageUrl!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.home, size: 40),
                    ),
                  ),
                ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ScrollUpWidthAnimation(
                    duration: const Duration(seconds: 1),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.main.light.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      height: 33 + 16,

                      // padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.only(
                        bottom: 12.0,
                        left: 15,
                        right: 15,
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: ScaleInWidget(
                                      delay: const Duration(seconds: 1),
                                      child: Text(
                                        property.location,
                                        textAlign: property.isFeatured
                                            ? TextAlign.center
                                            : TextAlign.start,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13,
                                          color: AppColors.text,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              width: 30 + 16,
                              height: 30 + 16,
                              child: Container(
                                padding: EdgeInsets.zero,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.text.lightest
                                          .withOpacity(0.7),
                                      blurRadius: 10.931,
                                      spreadRadius: 0.319,
                                      offset: const Offset(1, 1),
                                      blurStyle: BlurStyle.outer,
                                      // offse,t: Offset(0, 0.1),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              width: 30 + 16,
                              height: 30 + 16,
                              child: _PropertyCardButton(
                                onPressed: () => (),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
