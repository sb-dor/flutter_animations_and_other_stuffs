import 'package:flutter/material.dart';

class FadeAnimation extends StatelessWidget {
  ///Animate from value
  ///
  ///[default value 0]
  final double? begin;

  ///Animate to value
  ///
  ///[default value 1]
  final double? end;

  ///Animation Duration
  ///
  ///[default is 750ms]
  final Duration? duration;

  ///Animation delay
  ///
  ///[default is 0]
  final double? intervalStart; //Задержка анимации

  ///Animation delay
  ///
  ///[default is 1]
  final double? intervalEnd; //Задержка анимации

  ///Animation Curve
  ///
  ///[default is Curves.fastOutSlowIn]
  final Curve? curve;

  ///This widget will be animated
  final Widget child;
  const FadeAnimation(
      {super.key,
      required this.child,
      this.begin,
      this.end,
      this.duration,
      this.intervalStart,
      this.intervalEnd,
      this.curve});


  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: begin ?? 0, end: end ?? 1),
        duration: duration ?? const Duration(milliseconds: 3000),
        curve: Interval(intervalStart ?? 0, intervalEnd ?? 1,
            curve: curve ?? Curves.fastOutSlowIn),
        child: child,
        builder: (context, value, child) =>
            Opacity(opacity: value, child: child));
  }
}
