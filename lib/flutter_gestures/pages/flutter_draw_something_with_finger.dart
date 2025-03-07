import 'package:flutter/material.dart';

class FlutterDrawSomethingWithFinger extends StatefulWidget {
  const FlutterDrawSomethingWithFinger({super.key});

  @override
  State<FlutterDrawSomethingWithFinger> createState() =>
      _FlutterDrawSomethingWithFingerState();
}

class _FlutterDrawSomethingWithFingerState
    extends State<FlutterDrawSomethingWithFinger> {
  Color? selectedColor;
  double xPos = 0.0;
  double yPos = 0.0;

  List<Widget> widgets = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Listener(
              onPointerMove: (PointerMoveEvent move) {
                debugPrint("${move.position}");
                widgets.add(
                  Positioned(
                    left: move.position.dx,
                    top: move.position.dy,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: selectedColor ?? Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                );
                setState(() {});
              },
              child: Container(
                color: Colors.amber,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: widgets,
                ),
              ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 50),
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
                    child: selectedColor == Colors.red
                        ? const Icon(Icons.check)
                        : const SizedBox(),
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
                    child: selectedColor == Colors.green
                        ? const Icon(Icons.check)
                        : const SizedBox(),
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
