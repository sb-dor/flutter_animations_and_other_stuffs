import 'package:flutter/material.dart';

class FlutterDragElementToWidgetAndPaster extends StatefulWidget {
  const FlutterDragElementToWidgetAndPaster({super.key});

  @override
  State<FlutterDragElementToWidgetAndPaster> createState() =>
      _FlutterDragElementToWidgetAndPasterState();
}

class _FlutterDragElementToWidgetAndPasterState extends State<FlutterDragElementToWidgetAndPaster> {
  int sum = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                LongPressDraggable(
                  data: 1, // for adding value
                  childWhenDragging: const SizedBox(),
                  feedback: Material(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      color: Colors.red,
                      child: const Text("Long press draggable"),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.red,
                    child: const Text("Long press draggable"),
                  ),
                ),
                const SizedBox(width: 10),
                Draggable(
                  data: 1, // for adding value
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.red,
                    child: const Text("Draggable"),
                  ),
                  feedback: Material(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      color: Colors.red,
                      child: const Text("Draggable"),
                    ),
                  ),
                  childWhenDragging: const SizedBox(),
                ),
              ],
            ),
            const Spacer(),
            DragTarget(
              // onAccept can accept anything
              onAccept: (int data) {
                sum += data;
                setState(() {});
              },
              builder:
                  (BuildContext context, List<Object?> candidateData, List<dynamic> rejectedData) {
                return Container(
                  width: 100,
                  height: 100,
                  color: Colors.green,
                  child: Text("${sum}"),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
