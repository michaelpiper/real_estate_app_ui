import 'package:flutter/material.dart';
import 'package:real_estate_app/features/home/data/usecases/format.dart';

class CountUpAnimation extends StatelessWidget {
  final int target;
  final TextStyle? style;
  final Duration duration;
  final Duration delay;
  final FormatNumberUseCase formater;
  const CountUpAnimation({
    super.key,
    required this.target,
    this.style,
    this.duration = const Duration(seconds: 2),
    this.delay = Duration.zero,
    this.formater = const FormatWithSpaceSeparator(),
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(delay),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Text("0", style: style);
        }

        return TweenAnimationBuilder<int>(
          tween: IntTween(begin: 0, end: target),
          duration: duration,
          builder: (context, value, _) {
            return Text(formater(value), style: style);
          },
        );
      },
    );
  }
}
