import 'dart:math';

import 'package:flutter/material.dart';

class CustomPainterPathGuide extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black;

    var paint2 = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue;

    var paint3 = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.orange
      ..strokeWidth = 5;

    var path = Path();

    var path2 = Path();

    var path3 = Path();

    //rectangle
    path.addRect(Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width / 2,
        height: size.height / 2));

    //circle
    path2.addOval(Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width / 2,
        height: size.height / 2));

    //drawing
    path3.arcTo(
        Rect.fromCenter(
            center: Offset(size.width / 2, size.height / 2),
            width: size.width / 2,
            height: size.height / 2),
        -pi / 2,
        (0.5 * (pi * 2)),
        false);

    canvas.drawPath(path, paint);
    canvas.drawPath(path2, paint2);
    canvas.drawPath(path3, paint3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
