import 'dart:math';

import 'package:flutter/material.dart';

class Polygon extends CustomPainter {
  final int sides;

  Polygon({super.repaint, required this.sides});

  @override
  void paint(Canvas canvas, Size size) {
    //painter is something line your pencil or your brush
    final painter = Paint()
      //the painter color
      ..color = Colors.blue
      //the style of pencil (like you are choosing type of pencil)
      ..style = PaintingStyle.stroke
      //the corners
      ..strokeCap = StrokeCap.round
      //the size of pencil
      ..strokeWidth = 3;

    final path = Path();

    //take the center of the canvas
    final center = Offset(size.width / 2, size.height / 2);

    //what angle should be each size of drawing
    final angle = (pi * 2) / sides;

    //create each angles
    final angles = List.generate(sides, (index) => angle * index);

    //the radius of circle where everything should draw
    final radius = size.width / 2;

    path.moveTo(
      center.dx + radius * cos(0),
      center.dy + radius * sin(0),
    );

    for (var each in angles) {
      path.lineTo(
        center.dx + radius * cos(each),
        center.dy + radius * sin(each),
      );
    }

    path.close();

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate is Polygon && oldDelegate.sides != sides;
}

class CustomerPainterAndPolygons extends StatefulWidget {
  const CustomerPainterAndPolygons({super.key});

  @override
  State<CustomerPainterAndPolygons> createState() => _CustomerPainterAndPolygonsState();
}

class _CustomerPainterAndPolygonsState extends State<CustomerPainterAndPolygons>
    with TickerProviderStateMixin {
  late AnimationController _animationSizeController;
  late Animation<int> _animation;

  late AnimationController _moveAnimationController;
  late Animation<double> _moveAnimation;

  late AnimationController _radiusController;
  late Animation<double> _radiusAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animationSizeController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));

    _animation = IntTween(begin: 10, end: 3)
        .animate(CurvedAnimation(parent: _animationSizeController, curve: Curves.bounceOut));

    _moveAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));

    _moveAnimation = Tween<double>(begin: 0, end: -pi)
        .animate(CurvedAnimation(parent: _moveAnimationController, curve: Curves.bounceOut));

    _radiusController = AnimationController(vsync: this, duration: const Duration(seconds: 5));

    _radiusAnimation = Tween<double>(begin: 400, end: 30)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_radiusController);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationSizeController.dispose();
    _moveAnimationController.dispose();
    _radiusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationSizeController
      ..reset()
      ..repeat(reverse: true);

    _radiusController
      ..reset()
      ..repeat(reverse: true);

    _moveAnimationController
      ..reset()
      ..repeat(reverse: true);

    return Scaffold(
        body: Center(
      child: AnimatedBuilder(
          animation: Listenable.merge([
            _animationSizeController,
            _moveAnimationController,
            _radiusController,
          ]),
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateZ(_moveAnimation.value)
                ..rotateY(_moveAnimation.value)
                ..rotateX(_moveAnimation.value),
              child: CustomPaint(
                  painter: Polygon(sides: _animation.value),
                  child: SizedBox(
                    width: _radiusAnimation.value,
                    height: _radiusAnimation.value,
                  )),
            );
          }),
    ));
  }
}
