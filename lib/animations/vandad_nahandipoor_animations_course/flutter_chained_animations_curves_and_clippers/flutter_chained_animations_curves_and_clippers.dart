import 'dart:math';

import 'package:flutter/material.dart';

enum CircleSide { left, right }

extension ToPath on CircleSide {
  Path toPath(Size size) {
    final path = Path();

    late Offset offset;
    late bool clockWise;

    switch (this) {
      case CircleSide.left:
        path.moveTo(size.width, 0);
        offset = Offset(size.width, size.height);
        clockWise = false;
        break;
      case CircleSide.right:
        path.moveTo(0, 0);
        offset = Offset(0, size.height);
        clockWise = true;
        break;
    }
    path.arcToPoint(offset,
        radius: Radius.elliptical(size.width / 2, size.height / 2), clockwise: clockWise);

    path.close();

    return path;
  }
}

extension on VoidCallback {
  Future<void> delayed({required Duration duration}) => Future.delayed(duration, this);
}

class HalfCircleClipper extends CustomClipper<Path> {
  final CircleSide side;

  const HalfCircleClipper({required this.side});

  @override
  Path getClip(Size size) => side.toPath(size);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class FlutterChainedAnimationsCurvesAndClippers extends StatefulWidget {
  const FlutterChainedAnimationsCurvesAndClippers({Key? key}) : super(key: key);

  @override
  State<FlutterChainedAnimationsCurvesAndClippers> createState() =>
      _FlutterChainedAnimationsCurvesAndClippersState();
}

class _FlutterChainedAnimationsCurvesAndClippersState
    extends State<FlutterChainedAnimationsCurvesAndClippers> with TickerProviderStateMixin {
  // SingleTickerProviderStateMixin can have only one animationController
  // TickerProviderStateMixin can have more than one animationControllers

  late AnimationController _controller;

  late Animation<double> _animationDouble;

  late AnimationController _flipAnimationController;

  late Animation<double> _flipAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _animationDouble = Tween<double>(begin: 0, end: -(pi / 2)).animate(
      CurvedAnimation(parent: _controller, curve: Curves.bounceOut),
    );

    _flipAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _flipAnimation = Tween<double>(begin: 0, end: pi)
        .animate(CurvedAnimation(parent: _flipAnimationController, curve: Curves.bounceOut));

    //status listener
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _flipAnimation = Tween<double>(begin: _flipAnimation.value, end: _flipAnimation.value + pi)
            .animate(CurvedAnimation(parent: _flipAnimationController, curve: Curves.bounceOut));

        //reset the flip controller and start the animation
        _flipAnimationController
          ..reset()
          ..forward();
      }
    });

    _flipAnimationController.addStatusListener((status) {
      if (_flipAnimationController.status == AnimationStatus.completed) {
        _animationDouble =
            Tween<double>(begin: _animationDouble.value, end: -(pi / 2) - _animationDouble.value)
                .animate(
          CurvedAnimation(parent: _controller, curve: Curves.bounceOut),
        );
        _controller
          ..reset()
          ..forward();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    _flipAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller
      ..reset()
      ..forward.delayed(duration: const Duration(seconds: 1));
    return Scaffold(
      body: SafeArea(
        child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateZ(_animationDouble.value),
                  child: AnimatedBuilder(
                      animation: _flipAnimationController,
                      builder: (context, child) {
                        return Transform(
                          transform: Matrix4.identity()..rotateY(_flipAnimation.value),
                          alignment: Alignment.center,
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            ClipPath(
                              clipper: const HalfCircleClipper(side: CircleSide.left),
                              child: Container(
                                color: Colors.blue,
                                width: 100,
                                height: 100,
                              ),
                            ),
                            ClipPath(
                              clipper: const HalfCircleClipper(side: CircleSide.right),
                              child: Container(
                                color: Colors.yellow,
                                width: 100,
                                height: 100,
                              ),
                            )
                          ]),
                        );
                      }));
            }),
      ),
    );
  }
}
