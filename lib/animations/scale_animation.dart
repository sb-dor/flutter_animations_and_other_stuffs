import 'package:flutter/material.dart';

class ScaleAnimation extends StatelessWidget {
  ///Animate from value
  ///
  ///[default value 0.4]
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

  const ScaleAnimation(
      {Key? key,
      this.begin,
      this.end,
      required this.child,
      this.duration,
      this.intervalEnd,
      this.intervalStart,
      this.curve})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        tween: Tween<double>(begin: begin ?? 2, end: end ?? 1),
        duration: duration ?? const Duration(milliseconds: 750),
        curve: Interval(intervalStart ?? 0, intervalEnd ?? 1,
            curve: curve ?? Curves.fastOutSlowIn),
        builder: (context, value, child) =>
            Transform.scale(scale: value, child: child),
        child: child);
  }
}
