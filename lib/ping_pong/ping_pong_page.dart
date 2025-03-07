import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PingPongPage extends StatefulWidget {
  const PingPongPage({super.key});

  @override
  State<PingPongPage> createState() => _PingPongPageState();
}

class _PingPongPageState extends State<PingPongPage> {
  double playerX = 0;

  moveRight() {
    setState(() {
      if (playerX >= 0.9) return;
      playerX += 0.1;
    });
    print(playerX);
  }

  moveLeft() {
    setState(() {
      if (playerX <= -0.9) return;
      playerX -= 0.1;
    });
    print(playerX);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: RawKeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKey: (event) {
          if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
            moveRight();
          } else if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
            moveLeft();
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(children: [
              Container(
                alignment: Alignment(playerX, -1),
                height: 20,
                child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10))),
              ),
              Container(
                alignment: const Alignment(0, 1),
                height: 20,
                child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10))),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
