import 'package:flutter/material.dart';

class ScrollUpWidthAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;

  const ScrollUpWidthAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
  });

  @override
  State<ScrollUpWidthAnimation> createState() => _ScrollUpWidthAnimationState();
}

class _ScrollUpWidthAnimationState extends State<ScrollUpWidthAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _WidthFactor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _WidthFactor = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
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
      animation: _WidthFactor,
      builder: (context, child) {
        return ClipRect(
          child: Align(
            alignment: Alignment.bottomCenter,
            widthFactor: _WidthFactor.value,
            child: AnimatedBuilder(
              animation: _WidthFactor,
              builder: (_, child) => child!,
              child: widget.child,
            ),
          ),
        );
      },
    );
  }
}

class ScrollUpHeightAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;

  const ScrollUpHeightAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
  });

  @override
  State<ScrollUpHeightAnimation> createState() =>
      _ScrollUpHeightAnimationState();
}

class _ScrollUpHeightAnimationState extends State<ScrollUpHeightAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _HeightFactor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _HeightFactor = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
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
      animation: _HeightFactor,
      builder: (context, child) {
        return ClipRect(
          child: Align(
            alignment: Alignment.bottomCenter,
            heightFactor: _HeightFactor.value,
            child: AnimatedBuilder(
              animation: _HeightFactor,
              builder: (_, child) => child!,
              child: widget.child,
            ),
          ),
        );
      },
    );
  }
}

class ScrollUpAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;

  const ScrollUpAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
  });

  @override
  State<ScrollUpAnimation> createState() => _ScrollUpAnimationState();
}

class _ScrollUpAnimationState extends State<ScrollUpAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _factor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _factor = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
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
      animation: _factor,
      builder: (context, child) {
        return ClipRect(
          child: Align(
            alignment: Alignment.bottomCenter,
            heightFactor: _factor.value,
            widthFactor: _factor.value,
            child: AnimatedBuilder(
              animation: _factor,
              builder: (_, child) => child!,
              child: widget.child,
            ),
          ),
        );
      },
    );
  }
}
