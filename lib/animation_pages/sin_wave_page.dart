import 'dart:math';

import 'package:flutter/material.dart';

class SineWavePage extends StatefulWidget {
  const SineWavePage({super.key});

  @override
  State<SineWavePage> createState() => _SineWavePageState();
}

class _SineWavePageState extends State<SineWavePage> with SingleTickerProviderStateMixin {
  late AnimationController _sineAnimationController;
  late Animation<double> _sineAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _sineAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _sineAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
      CurvedAnimation(parent: _sineAnimationController, curve: Curves.linear),
    );

    _sineAnimationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Loading Animation Page"),
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
            }));
  }
}

class SinePainter extends CustomPainter {
  Animation<double> animation;

  SinePainter({required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    Path path = Path()..moveTo(0, size.height / 2);

    for (int i = 0; i <= 30; i++) {
      path.lineTo(i * size.width / 30, size.height / 2 + sin(animation.value + i * pi / 15) * 20);
    }

    path.lineTo(size.width, size.height / 2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
