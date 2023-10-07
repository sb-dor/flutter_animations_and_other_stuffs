import 'dart:math' show pi;
import 'package:flutter/material.dart';

class FlutterAnimatedBuilderAndTMainScreen extends StatefulWidget {
  const FlutterAnimatedBuilderAndTMainScreen({Key? key}) : super(key: key);

  @override
  State<FlutterAnimatedBuilderAndTMainScreen> createState() =>
      _FlutterAnimatedBuilderAndTMainScreenState();
}

class _FlutterAnimatedBuilderAndTMainScreenState extends State<FlutterAnimatedBuilderAndTMainScreen>
    with SingleTickerProviderStateMixin {
  // SingleTickerProviderStateMixin can have only one animationController
  // TickerProviderStateMixin can have more than one animationControllers

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));

    //2π радиан = 360°
    // π радиан = 180°
    // π/2 радиан = 180 / 2 = 90°
    // π/3 радиан = 180 / 3 = 60°
    // π/4 радиан = 180 / 4 = 45°
    // π/5 радиан = 180 / 5 = 36°
    // π/6 радиан = 180 / 6 = 30°
    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);

    _controller.repeat();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateZ(_animation.value),
                  child: Container(
                    width: 100,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3)),
                      ],
                    ),
                  ),
                );
              })),
    );
  }
}
