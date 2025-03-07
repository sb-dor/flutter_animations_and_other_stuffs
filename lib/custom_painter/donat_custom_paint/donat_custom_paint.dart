import 'dart:math';
import 'package:flutter/material.dart';

class DataItem {
  final double value;
  final String label;
  final Color color;

  late AnimationController _animationController;
  late Animation<double> animation;

  DataItem({
    required this.value,
    required this.label,
    required this.color,
    required TickerProvider provider,
  }) {
    _animationController =
        AnimationController(vsync: provider, duration: const Duration(seconds: 2));
    animation = Tween<double>(begin: 0, end: value)
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn));
    _animationController.forward();
  }
}

class DonalCustomPaint extends StatefulWidget {
  const DonalCustomPaint({super.key});

  @override
  State<DonalCustomPaint> createState() => _DonalCustomPaintState();
}

class _DonalCustomPaintState extends State<DonalCustomPaint> with TickerProviderStateMixin {
  List<AnimationController> animationControllers = [];

  List<DataItem> dataItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    dataItems = [
      DataItem(value: 0.2, label: "Comedy", color: Colors.red, provider: this),
      DataItem(value: 0.25, label: "Action", color: Colors.amber, provider: this),
      DataItem(value: 0.3, label: "Romance", color: Colors.blue, provider: this),
      DataItem(value: 0.05, label: "Drama", color: Colors.green, provider: this),
      DataItem(value: 0.2, label: "SciFi", color: Colors.orange, provider: this),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomPaint(
              painter: DonatChartPainter(dataItems),
              child: const SizedBox(
                width: 200,
                height: 200,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DonatChartPainter extends CustomPainter {
  List<DataItem> items;

  DonatChartPainter(this.items) : super(repaint: items.first.animation);

  final Paint whitePainterInCircle = Paint()
    ..color = Colors.white
    ..strokeWidth = 2;

  final midPainter = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final radius = size.width * 0.9;

    final rect = Rect.fromCenter(center: center, width: radius, height: radius);

    var startAngle = 0.0;

    for (var each in items) {
      // drawing arcs
      final paint = Paint()
        ..color = each.color
        ..style = PaintingStyle.fill;

      final sweepAngle = each.animation.value * 360 * pi / 180;

      canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
      //

      //drawing lines
      final dx = radius / 2 * cos(startAngle);

      final dy = radius / 2 * sin(startAngle);

      final p2 = center + Offset(dx, dy);

      canvas.drawLine(center, p2, whitePainterInCircle);
      //

      final r = radius * 0.4;
      final x = r * cos(startAngle + sweepAngle / 2);
      final y = r * sin(startAngle + sweepAngle / 2);
      final pos = center + Offset(x, y);

      drawTextCentered(
        canvas,
        pos,
        each.label,
        const TextStyle(color: Colors.black, fontSize: 10),
        radius * 0.3,
      );

      startAngle += sweepAngle;
    }

    // draw middle white circle
    canvas.drawCircle(center, radius * 0.3, midPainter);

    // draw title
    drawTextCentered(canvas, center, "Favorite dates",
        const TextStyle(color: Colors.black, fontSize: 15), radius * 0.6);
  }

  TextPainter measureText(String s, TextStyle textStyle, double maxWidth, TextAlign textAlign) {
    final span = TextSpan(text: s, style: textStyle);
    final tp = TextPainter(text: span, textAlign: textAlign, textDirection: TextDirection.ltr);
    tp.layout(minWidth: 0, maxWidth: maxWidth);
    return tp;
  }

  Size drawTextCentered(
      Canvas canvas, Offset position, String text, TextStyle textStyle, double maxWidth) {
    final tp = measureText(text, textStyle, maxWidth, TextAlign.center);
    final pos = position + Offset(-tp.width / 2, -tp.height / 2);
    tp.paint(canvas, pos);
    return tp.size;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
