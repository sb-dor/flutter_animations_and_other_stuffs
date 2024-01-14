import 'dart:math';

import 'package:flutter/material.dart';

class LoadingAnimationPage extends StatefulWidget {
  const LoadingAnimationPage({super.key});

  @override
  State<LoadingAnimationPage> createState() => _LoadingAnimationPageState();
}

class _LoadingAnimationPageState extends State<LoadingAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _sineAnimationController;
  late Animation<double> _sineAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _sineAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _sineAnimation = Tween<double>(begin: 0, end: 200).animate(
      CurvedAnimation(parent: _sineAnimationController, curve: Curves.linear),
    );

    _sineAnimationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sin wave page"),
        backgroundColor: Colors.blueGrey,
      ),
      body: AnimatedBuilder(
          animation: _sineAnimationController,
          builder: (context, child) {
            return Center(
              child: SizedBox(
                width: 300,
                height: 300,
                child: CustomPaint(
                  painter: SinePainter(animation: _sineAnimation),
                ),
              ),
            );
          }),
    );
  }
}

class SinePainter extends CustomPainter {
  Animation<double> animation;

  SinePainter({required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    if (animation.value >= 100) {
      Paint paint = Paint()
        ..color = Colors.white
        ..strokeCap = StrokeCap.butt
        ..strokeWidth = 5
        ..style = PaintingStyle.stroke;
      Path path = Path();
      path.arcTo(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2), radius: 20),
        -pi / 2,
        (animation.value * (pi * 2)) / 100,
        false,
      );

      Paint paint2 = Paint()
        ..color = Colors.amber
        ..strokeCap = StrokeCap.butt
        ..strokeWidth = 5
        ..style = PaintingStyle.stroke;
      Path path2 = Path();
      path2.arcTo(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2), radius: 20),
        0,
        pi * 1.99,
        false,
      );

      // canvas.drawShadow(path, Colors.white, 5, false);
      canvas.drawPath(path2, paint2);
      canvas.drawPath(path, paint);
    } else {
      Paint paint = Paint()
        ..color = Colors.amber
        ..strokeCap = StrokeCap.butt
        ..strokeWidth = 5
        ..style = PaintingStyle.stroke;
      Path path = Path();
      path.arcTo(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2), radius: 20),
        -pi / 2,
        (animation.value * (pi * 2)) / 100,
        false,
      );

      // canvas.drawShadow(path, Colors.white, 5, false);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
