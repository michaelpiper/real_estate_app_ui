import 'package:flutter/material.dart';

class RevealTextAnimation extends StatefulWidget {
  final String data;
  final TextStyle? style;
  final Duration duration;
  final Duration delay;

  const RevealTextAnimation(
    this.data, {
    super.key,
    this.style,
    this.duration = const Duration(seconds: 2),
    this.delay = Duration.zero,
  });

  @override
  State<RevealTextAnimation> createState() => _RevealTextAnimationState();
}

class _RevealTextAnimationState extends State<RevealTextAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ClipRect(
          child: Align(
            alignment: Alignment.centerLeft,
            heightFactor: _animation.value,
            child: child,
          ),
        );
      },
      child: Text(
        widget.data,
        style: widget.style,
      ),
    );
  }
}
