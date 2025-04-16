import 'package:flutter/material.dart';

class GrowHeightAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final double? height;
  const GrowHeightAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.height,
  });

  @override
  State<GrowHeightAnimation> createState() => _GrowHeightAnimationState();
}

class _GrowHeightAnimationState extends State<GrowHeightAnimation>
    with SingleTickerProviderStateMixin {
  final GlobalKey _childKey = GlobalKey();
  late double _targetHeight = 0;
  bool _startAnimation = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = _childKey.currentContext;
      if (context != null) {
        final size = context.size;
        if (size != null && mounted) {
          setState(() {
            _targetHeight = size.height;
          });
        }
      }
      Future.delayed(widget.delay, () {
        if (mounted) setState(() => _startAnimation = true);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.height == null && _targetHeight == 0
        ? Opacity(
            // Invisible widget to measure child height
            opacity: 0,
            child: Container(
              key: _childKey,
              child: widget.child,
            ),
          )
        : TweenAnimationBuilder<double>(
            tween: Tween<double>(
              begin: 0,
              end: _startAnimation ? widget.height ?? _targetHeight : 0,
            ),
            duration: widget.duration,
            curve: Curves.easeOut,
            builder: (context, value, child) {
              return SizedBox(
                height: value,
                child: widget.child,
              );
            },
          );
  }
}
