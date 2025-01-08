import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

const double widthAndHeight = 100;

class ThirdDAnimationsInFlutterHowToStackAndRotateWidget extends StatefulWidget {
  const ThirdDAnimationsInFlutterHowToStackAndRotateWidget({super.key});

  @override
  State<ThirdDAnimationsInFlutterHowToStackAndRotateWidget> createState() =>
      _ThirdDAnimationsInFlutterHowToStackAndRotateWidgetState();
}

class _ThirdDAnimationsInFlutterHowToStackAndRotateWidgetState
    extends State<ThirdDAnimationsInFlutterHowToStackAndRotateWidget>
    with TickerProviderStateMixin {
  //
  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _zController;

  late Tween<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _xController = AnimationController(vsync: this, duration: const Duration(seconds: 20));

    _yController = AnimationController(vsync: this, duration: const Duration(seconds: 20));

    _zController = AnimationController(vsync: this, duration: const Duration(seconds: 20));

    _animation = Tween<double>(begin: 0, end: pi * 2);
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _xController
      ..reset()
      ..repeat();

    _yController
      ..reset()
      ..repeat();

    _zController
      ..reset()
      ..repeat();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: widthAndHeight, width: double.infinity),
            AnimatedBuilder(
                //to listen multiple animations in animationBuilder
                animation: Listenable.merge([_xController, _yController, _zController]),
                builder: (context, child) {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      //to work with multiple controllers value with one animation type
                      ..rotateX(_animation.evaluate(_xController))
                      ..rotateY(_animation.evaluate(_yController))
                      ..rotateZ(_animation.evaluate(_zController)),
                    child: Stack(children: [
                      //front
                      Container(
                        color: Colors.green,
                        width: widthAndHeight,
                        height: widthAndHeight,
                      ),

                      //left size
                      Transform(
                        alignment: Alignment.centerLeft,
                        transform: Matrix4.identity()..rotateY(pi / 2),
                        child: Container(
                          color: Colors.red,
                          width: widthAndHeight,
                          height: widthAndHeight,
                        ),
                      ),

                      //right size

                      Transform(
                        alignment: Alignment.centerRight,
                        transform: Matrix4.identity()..rotateY(-(pi / 2)),
                        child: Container(
                          color: Colors.red,
                          width: widthAndHeight,
                          height: widthAndHeight,
                        ),
                      ),

                      //top side

                      Transform(
                        alignment: Alignment.bottomCenter,
                        transform: Matrix4.identity()..rotateX(pi / 2),
                        child: Container(
                          color: Colors.blue,
                          width: widthAndHeight,
                          height: widthAndHeight,
                        ),
                      ),

                      //bottom

                      Transform(
                        alignment: Alignment.topCenter,
                        transform: Matrix4.identity()..rotateX(-pi / 2),
                        child: Container(
                          color: Colors.blueAccent,
                          width: widthAndHeight,
                          height: widthAndHeight,
                        ),
                      ),

                      //back
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..translate(vector.Vector3(0, 0, -widthAndHeight)),
                        child: Container(
                          color: Colors.purple,
                          width: widthAndHeight,
                          height: widthAndHeight,
                        ),
                      ),

                      //
                    ]),
                  );
                })
          ],
        ),
      ),
    );
  }
}
