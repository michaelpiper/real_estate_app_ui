// lib/features/property/presentation/widgets/property_list.dart
import 'package:flutter/material.dart';
import 'package:real_estate_app/core/theme/app_colors.dart';
import 'package:real_estate_app/core/theme/text_styles.dart';
import 'package:real_estate_app/features/property/domain/entities/property.dart';

class PropertyList extends StatelessWidget {
  final List<Property> properties;
  final ScrollController? scrollController;
  final bool shrinkWrap;
  final EdgeInsets? padding;

  const PropertyList({
    super.key,
    required this.properties,
    this.scrollController,
    this.shrinkWrap = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    if (properties.isEmpty) {
      return const Center(
        child: Text(
          'No properties found',
          style: TextStyles.bodyMedium,
        ),
      );
    }

    return ListView.builder(
      controller: scrollController,
      shrinkWrap: shrinkWrap,
      padding: padding ?? const EdgeInsets.all(16),
      itemCount: properties.length,
      itemBuilder: (context, index) {
        final property = properties[index];
        return _PropertyListItem(
          property: property,
          isLast: index == properties.length - 1,
        );
      },
    );
  }
}

class _PropertyListItem extends StatelessWidget {
  final Property property;
  final bool isLast;

  const _PropertyListItem({
    required this.property,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Navigate to property details
          // context.push('/property/${property.id}');
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    property.imageUrl!,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.card,
                      child: const Icon(Icons.home_outlined, size: 48),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    property.formattedPrice,
                    style: TextStyles.titleMedium.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  _buildPropertyBadge(property),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                property.title,
                style: TextStyles.titleSmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      property.location,
                      style: TextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildFeatureChip(
                    icon: Icons.bed_outlined,
                    label: '${property.bedrooms}',
                  ),
                  const SizedBox(width: 8),
                  _buildFeatureChip(
                    icon: Icons.bathtub_outlined,
                    label: '${property.bathrooms}',
                  ),
                  const SizedBox(width: 8),
                  _buildFeatureChip(
                    icon: Icons.aspect_ratio_outlined,
                    label: '${property.area} sqft',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPropertyBadge(Property property) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: property.status == PropertyStatus.forRent
            ? AppColors.success.withOpacity(0.1)
            : AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        property.status.displayName,
        style: TextStyles.labelSmall.copyWith(
          color: property.status == PropertyStatus.forRent
              ? AppColors.success
              : AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildFeatureChip({required IconData icon, required String label}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
