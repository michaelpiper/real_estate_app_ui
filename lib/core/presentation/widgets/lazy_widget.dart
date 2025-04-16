import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class LazyVisible extends StatefulWidget {
  final Widget? child;
  final Duration delay; // Optional delay before showing
  final Widget? placeholder;
  final Function(BuildContext context, Widget? child)? builder;

  // const LazyVisible._({
  //   super.key,
  //   this.child,
  //   this.delay = Duration.zero,
  //   this.placeholder,
  //   this.builder,
  // });

  const LazyVisible({
    super.key,
    this.delay = Duration.zero,
    this.placeholder,
    required Widget this.child,
  }) : builder = null;

  const LazyVisible.builder({
    super.key,
    this.delay = Duration.zero,
    this.placeholder,
    this.child,
    required Function(BuildContext context, Widget? child) this.builder,
  });

  @override
  State<LazyVisible> createState() => _LazyVisibleState();
}

class _LazyVisibleState extends State<LazyVisible> {
  bool _isVisible = false;
  bool _delayCompleted = false;

  @override
  void initState() {
    super.initState();
    if (widget.delay != Duration.zero) {
      Future.delayed(widget.delay, () {
        if (mounted) setState(() => _delayCompleted = true);
      });
    } else {
      _delayCompleted = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('lazy_visible_${widget.key ?? UniqueKey()}'),
      onVisibilityChanged: (info) {
        if (mounted && info.visibleFraction > 0.5 && !_isVisible) {
          setState(() => _isVisible = true);
        }
      },
      child: _shouldShowChild
          ? _builder()
          : widget.placeholder ?? _defaultPlaceholder(),
    );
  }

  bool get _shouldShowChild => _delayCompleted && _isVisible;
  Widget _builder() {
    if (widget.builder != null) {
      return widget.builder!(context, widget.child);
    }
    if (widget.child != null) {
      return widget.child!;
    }
    return const SizedBox();
  }

  Widget _defaultPlaceholder() {
    return Container(
      color: Colors.grey[200],
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }
}
