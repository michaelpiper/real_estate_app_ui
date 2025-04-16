// lib/features/main/presentation/widgets/bottom_bar_item.dart
import 'package:flutter/material.dart';
import 'package:real_estate_app/core/theme/app_colors.dart';

class BottomBarItem extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final Color activeColor;
  final Color activeBgColor;
  final Color inactiveColor;
  final Color inactiveBgColor;
  final VoidCallback onTap;

  const BottomBarItem({
    super.key,
    required this.icon,
    required this.isActive,
    required this.activeColor,
    required this.activeBgColor,
    Color? inactiveColor,
    Color? inactiveBgColor,
    required this.onTap,
  })  : inactiveColor = inactiveColor ?? AppColors.textSecondary,
        inactiveBgColor = inactiveBgColor ?? AppColors.textSecondary;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInCubic,
        padding: EdgeInsets.all(isActive ? 14 : 8),
        decoration: BoxDecoration(
          color: isActive ? activeBgColor : inactiveBgColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: isActive ? 1.0 : 0.6,
          child: Icon(
            icon,
            color: isActive ? activeColor : inactiveColor,
            size: 25,
          ),
        ),
      ),
    );
  }
}
