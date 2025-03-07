import 'package:flutter/material.dart';

class FlutterAnimatedBuilderOwnTextMoving extends StatefulWidget {
  const FlutterAnimatedBuilderOwnTextMoving({super.key});

  @override
  State<FlutterAnimatedBuilderOwnTextMoving> createState() =>
      _FlutterAnimatedBuilderOwnTextMovingState();
}

class _FlutterAnimatedBuilderOwnTextMovingState
    extends State<FlutterAnimatedBuilderOwnTextMoving>
    with SingleTickerProviderStateMixin {
  // SingleTickerProviderStateMixin can have only one animationController
  // TickerProviderStateMixin can have more than one animationControllers

  late AnimationController _controller;

  late Animation<Offset> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));

    _animation = Tween(begin: const Offset(0, 0), end: const Offset(250, 0))
        .animate(_controller);

    _controller.repeat(reverse: true);

    //also you can listen the animation status
    // _controller.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     _controller.reverse();
    //   } else if (status == AnimationStatus.dismissed) {
    //     _controller.forward();
    //   }
    // });
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
                return Transform.translate(
                    offset: _animation.value,
                    child: const Text("A long text should be here",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)));
              })),
    );
  }
}
