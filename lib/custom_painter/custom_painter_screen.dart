import 'package:flutter/material.dart';
import 'package:flutter_animations_2/custom_painter/custom_painters.dart';

class CustomPainterScreen extends StatefulWidget {
  const CustomPainterScreen({Key? key}) : super(key: key);

  @override
  State<CustomPainterScreen> createState() => _CustomPainterScreenState();
}

class _CustomPainterScreenState extends State<CustomPainterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Custom Painters")),
      body: ListView(children: [
        Container(
          color: Colors.amber,
          child: CustomPaint(
            painter: CustomPainterPathGuide(),
            size: const Size(300, 400),
          ),
        )
      ]),
    );
  }
}
