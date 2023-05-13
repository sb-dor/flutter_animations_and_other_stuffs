import 'package:flutter/material.dart';

//animation from one position to another position
class SlideAnimation extends StatelessWidget {
  ///Animate from value
  ///
  ///[default value Offset(250,0)]
  final Offset? begin;

  ///Animate to value
  ///
  ///[default value Offset(0,0)]
  final Offset? end;

  ///Animation delay
  ///
  ///[default is 0]
  final double? intervalStart; //Задержка анимации

  ///Animation delay
  ///
  ///[default is 1]
  final double? intervalEnd; //Задержка анимации

  ///Animation Duration
  ///
  ///[default is 750ms]
  final Duration? duration;

  ///Animation Curve
  ///[default is Curves.fastOutSlowIn]
  final Curve? curve;

  ///This widget will be animated
  final Widget? child;

  const SlideAnimation(
      {Key? key,
      required this.child,
      this.begin,
      this.end,
      this.intervalStart,
      this.intervalEnd,
      this.duration,
      this.curve})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Offset>(
        tween: Tween<Offset>(
            begin: begin ?? const Offset(250, 0),
            end: end ?? const Offset(0, 0)),
        duration: duration ?? const Duration(milliseconds: 750),
        curve: Interval(intervalStart ?? 0, intervalEnd ?? 1,
            curve: curve ?? Curves.fastOutSlowIn),
        child: child,
        builder: (BuildContext context, Offset? value, Widget? child) =>
            Transform.translate(offset: value!, child: child));
  }
}
