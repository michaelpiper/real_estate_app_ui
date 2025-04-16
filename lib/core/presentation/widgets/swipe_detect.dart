import 'package:flutter/material.dart';

class SwipeDetector extends StatelessWidget {
  final VoidCallback onSwipeUp;
  final VoidCallback onSwipeDown;

  const SwipeDetector({
    super.key,
    required this.onSwipeUp,
    required this.onSwipeDown,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Vertical drag end to detect swipe direction
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity == null) return;

        if (details.primaryVelocity! < 0) {
          onSwipeUp(); // swipe up
        } else if (details.primaryVelocity! > 0) {
          onSwipeDown(); // swipe down
        }
      },
      child: Container(
        color: Colors.transparent, // invisible
        width: double.infinity,
        height: 100, // adjust swipe zone height
      ),
    );
  }
}
