import 'dart:math';

import 'package:flutter/material.dart';

class FlutterThreeDimensionDrawer extends StatefulWidget {
  const FlutterThreeDimensionDrawer({super.key});

  @override
  State<FlutterThreeDimensionDrawer> createState() =>
      _FlutterThreeDimensionDrawerState();
}

class _FlutterThreeDimensionDrawerState
    extends State<FlutterThreeDimensionDrawer> with TickerProviderStateMixin {
  late AnimationController drawerController;
  late AnimationController childController;
  late Animation<double> drawerAnimation;
  late Animation<double> childAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    drawerController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    childController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    drawerAnimation =
        Tween<double>(begin: 0, end: -pi / 2).animate(drawerController);

    childAnimation =
        Tween<double>(begin: 0, end: -pi / 2).animate(childController);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    childController.dispose();
    drawerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
          onHorizontalDragUpdate: (drag) {
            print("data dx : ${drag.delta.dx}");
          },
          child: const Stack(children: [MyDrawer(), MyChild()])),
    );
  }
}

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.red);
  }
}

class MyChild extends StatefulWidget {
  const MyChild({super.key});

  @override
  State<MyChild> createState() => _MyChildState();
}

class _MyChildState extends State<MyChild> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.red);
  }
}
