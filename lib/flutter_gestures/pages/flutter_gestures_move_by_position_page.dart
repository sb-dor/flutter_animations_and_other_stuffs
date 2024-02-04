import 'package:flutter/material.dart';

class FlutterGesturesMoveByPositionPage extends StatefulWidget {
  const FlutterGesturesMoveByPositionPage({super.key});

  @override
  State<FlutterGesturesMoveByPositionPage> createState() => _FlutterGesturesMoveByPositionState();
}

class _FlutterGesturesMoveByPositionState extends State<FlutterGesturesMoveByPositionPage> {
  double xPosition = 0.0;

  double yPosition = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      xPosition = MediaQuery.of(context).size.width / 2 - 25;
      yPosition = 125;
      setState(() {});
    });
  }

  final double containerHeight = 50.0;
  final double containerWidth = 50.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            color: Colors.green,
            child: Stack(
              children: [
                Positioned(
                  top: yPosition,
                  left: xPosition,
                  child: Listener(
                    onPointerMove: (PointerMoveEvent move) {
                      if ((move.position.dx - (containerWidth / 2)) < 0 ||
                          (move.position.dx + (containerWidth / 2)) >
                              MediaQuery.of(context).size.width) return;
                      if ((move.position.dy - containerHeight) < 0 || move.position.dy > 300) {
                        return;
                      }
                      debugPrint("${move.position.dx}");
                      xPosition = move.position.dx - (containerWidth / 2);
                      yPosition = move.position.dy - containerHeight;
                      setState(() {});
                    },
                    child: Container(
                      width: containerWidth,
                      height: containerHeight,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
