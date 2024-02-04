import 'package:flutter/material.dart';
import 'package:get/get.dart';

//
class DrawLinesPainter extends CustomPainter {
  final List<Offset> points;
  final Color? color;

  DrawLinesPainter({required this.points, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final painter = Paint()
      ..color = color ?? Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    final path = Path();
    if (points.isNotEmpty) {
      path.moveTo(points.first.dx, points.first.dy);
      for (int i = 0; i < points.length; i++) {
        path.lineTo(points[i].dx, points[i].dy);
      }
    }

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

//
class LineWidget {
  int id;
  List<Offset> points;
  Color? color;

  LineWidget({required this.id, required this.points, this.color = Colors.black});

  LineWidget clone() => LineWidget(id: id, points: points, color: color);
}

class FlutterDrawSomethingWithFingerNewOne extends StatefulWidget {
  const FlutterDrawSomethingWithFingerNewOne({Key? key}) : super(key: key);

  @override
  State<FlutterDrawSomethingWithFingerNewOne> createState() =>
      _FlutterDrawSomethingWithFingerFromNewOne();
}

class _FlutterDrawSomethingWithFingerFromNewOne
    extends State<FlutterDrawSomethingWithFingerNewOne> {
  Color? selectedColor;

  List<LineWidget> widgets = [];

  int lastId = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Listener(
              onPointerDown: (PointerDownEvent down) {
                lastId++;
                widgets.add(
                  LineWidget(
                    id: lastId,
                    points: [down.position],
                    color: selectedColor,
                  ),
                );
                debugPrint("added 1: ${widgets.length}");
                setState(() {});
              },
              onPointerMove: (PointerMoveEvent move) async {
                var findLine = widgets.firstWhereOrNull((el) => el.id == lastId)?.clone();
                if (findLine != null) {
                  findLine.points.add(move.position);
                  widgets[widgets.indexWhere((el) => el.id == lastId)] = findLine;
                }
                setState(() {});
              },
              child: Container(
                color: Colors.amber,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                    children: widgets
                        .map(
                          (e) => CustomPaint(
                            painter: DrawLinesPainter(
                              points: e.points,
                              color: e.color,
                            ),
                          ),
                        )
                        .toList()),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 50),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => setState(() {
                    selectedColor = Colors.red;
                  }),
                  child: Container(
                    width: 50,
                    height: 50,
                    color: Colors.red,
                    child: selectedColor == Colors.red ? const Icon(Icons.check) : const SizedBox(),
                  ),
                ),
                const SizedBox(width: 30),
                GestureDetector(
                  onTap: () => setState(() {
                    selectedColor = Colors.green;
                  }),
                  child: Container(
                    width: 50,
                    height: 50,
                    color: Colors.green,
                    child:
                        selectedColor == Colors.green ? const Icon(Icons.check) : const SizedBox(),
                  ),
                ),
                TextButton(
                  onPressed: () => setState(() {
                    widgets.clear();
                  }),
                  child: const Text("Clear"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
