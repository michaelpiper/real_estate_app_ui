import 'package:flutter/material.dart';
import 'package:real_estate_app/core/theme/app_colors.dart';

class MapMenuButton extends StatelessWidget {
  const MapMenuButton({
    super.key,
    this.iconData,
    this.menu = const [],
  });
  final IconData? iconData;
  final List<PopupMenuEntry<int>> menu;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        _showPopover(context);
      },
      style: IconButton.styleFrom(
        backgroundColor: AppColors.background.withOpacity(0.6),
      ),
      icon: Icon(
        iconData,
        color: AppColors.background,
      ),
    );
  }

  void _showPopover(BuildContext context) async {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final Offset buttonPosition =
        button.localToGlobal(Offset.zero); // Get the position of the button

    final double dy =
        buttonPosition.dy - 210; // Place above the button (adjust 50 for gap)

    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(0, dy, 0, 0), // Adjust the position here
      items: menu,
      menuPadding: const EdgeInsets.symmetric(horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      popUpAnimationStyle: AnimationStyle(
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 400),
      ),
    );
  }
}
