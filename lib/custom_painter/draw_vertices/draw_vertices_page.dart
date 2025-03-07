import 'dart:ui';

import 'package:flutter/material.dart';

class DrawVerticesPage extends StatefulWidget {
  const DrawVerticesPage({super.key});

  @override
  State<DrawVerticesPage> createState() => _DrawVerticesPageState();
}

class _DrawVerticesPageState extends State<DrawVerticesPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;
  late Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: 5).animate(
      CurvedAnimation(
        parent: _rotationController,
        curve: Easing.legacy,
      ),
    );

    _rotationController.forward();

    _rotationController.addListener(() {
      if (_rotationController.isCompleted) {
        _rotationController.reverse();
      }
      if (_rotationController.value == 0) {
        _rotationController.forward();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: AngleAnimation(_animation),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class AngleAnimation extends CustomPainter {
  final Animation<double> animation;

  AngleAnimation(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final paint = Paint()
      ..color = Colors.amber
      ..style = PaintingStyle.fill
      ..strokeWidth = 5;

    final points1 = [
      center + Offset(0, -animation.value),
      center + Offset(50 + animation.value, animation.value),
      center + Offset(50 + animation.value, 50 + animation.value),
      center + Offset(0, 50 - animation.value),
      center + Offset(0, -animation.value)
    ];

    // final vertices = Vertices(
    //   VertexMode.triangles,
    //   [
    //     center,
    //     center + Offset(50, 0),
    //     center + Offset(0, 30),
    //     center + Offset(50, 30),
    //   ],
    // );

    canvas.drawPoints(PointMode.polygon, points1, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class ExamplePainter extends CustomPainter {
  final Animation<double> rotation;

  ExamplePainter(this.rotation) : super(repaint: rotation);

  final Paint _paint = Paint()..color = const Color(0xFFFF33FF);

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.shortestSide / 3;

    final center = Offset(size.width / 2, size.height / 2);

    final Vertices vertices = Vertices(
      VertexMode.triangles,
      [
        center,
        center + const Offset(100, 0),
        center + const Offset(100, 100),
        center + const Offset(0, 100),
      ],
      colors: [
        Colors.red,
        Colors.green,
        Colors.blue,
        Colors.black,
      ],
      // index of positions from top that will be used
      // ( you can use every of them with no limits) only if it create triangle
      indices: [0, 2, 3, 1, 2, 3],
    );

    canvas.drawVertices(vertices, BlendMode.dst, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
