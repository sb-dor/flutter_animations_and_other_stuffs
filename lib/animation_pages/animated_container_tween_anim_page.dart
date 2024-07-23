import 'package:flutter/material.dart';

class AnimatedContainerPage extends StatelessWidget {
  const AnimatedContainerPage({Key? key}) : super(key: key);

  //usually tween animation builder uses at the beginning of creating UI
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: AnimatedContainer()));
  }
}

class AnimatedContainer extends StatefulWidget {
  const AnimatedContainer({Key? key}) : super(key: key);

  @override
  State<AnimatedContainer> createState() => _AnimatedContainerState();
}

class _AnimatedContainerState extends State<AnimatedContainer> {
  late double y;
  late double x;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    y = -3;
    x = 0;
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        tween: Tween<Offset>(begin: Offset(x, y), end: Offset(x, -y)),
        duration: const Duration(milliseconds: 375),
        child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Hello"), Text("World")]),
        builder: (context, val, child) => Listener(
              onPointerUp: (v) => setState(() {
                y = 3;
                x = 2;
              }),
              onPointerDown: (v) => setState(() {
                y = -3;
                x = 0;
              }),
              child: MouseRegion(
                onEnter: (v) => setState(() {
                  y = 3;
                  x = 2;
                }),
                onExit: (v) => setState(() {
                  y = -3;
                  x = 0;
                }),
                child: Container(
                    height: 100,
                    width: 200,
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(offset: val, color: Colors.grey),
                      BoxShadow(offset: val, color: Colors.grey)
                    ]),
                    child: child),
              ),
            ));
  }
}
