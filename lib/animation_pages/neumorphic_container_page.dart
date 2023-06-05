import 'package:flutter/material.dart';

class NeumorphicContainer extends StatefulWidget {
  const NeumorphicContainer({super.key});

  @override
  NeumorphicContainerState createState() => NeumorphicContainerState();
}

class NeumorphicContainerState extends State<NeumorphicContainer> {
  bool _isPressed = false;

  bool switchWidget = false;

  bool physicalModelButton = false;

  bool decBoxTransition =false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  onTapDown: (_) => setState(() => _isPressed = true),
                  onTapUp: (_) => setState(() => _isPressed = false),
                  onTapCancel: () => setState(() => _isPressed = false),
                  child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: _isPressed
                            ? [
                                BoxShadow(
                                    color: Colors.grey[300]!,
                                    offset: const Offset(4, 4),
                                    blurRadius: 6,
                                    spreadRadius: 2),
                                const BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(-4, -4),
                                    blurRadius: 6,
                                    spreadRadius: 2),
                              ]
                            : [
                                BoxShadow(
                                    color: Colors.grey[300]!,
                                    offset: const Offset(-4, -4),
                                    blurRadius: 6,
                                    spreadRadius: 1),
                                const BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(4, 4),
                                    blurRadius: 6,
                                    spreadRadius: 1),
                              ],
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text('Neumorphic Container',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700]))))),
              SizedBox(height: 30),
              AnimatedCrossFade(
                  firstChild: GestureDetector(
                    onTap: () {
                      setState(() {
                        switchWidget = !switchWidget;
                        print('eee');
                      });
                    },
                    child: Container(
                        color: Colors.green,
                        width: 200,
                        height: 100,
                        child: const Center(child: Text("AnimatedCrossFade"))),
                  ),
                  secondChild: GestureDetector(
                    onTap: () {
                      setState(() {
                        switchWidget = !switchWidget;
                        print('www');
                      });
                    },
                    child: Container(
                        color: Colors.red,
                        width: 200,
                        height: 150,
                        child: const Center(child: Text("AnimatedCrossFade"))),
                  ),
                  crossFadeState: switchWidget
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: const Duration(seconds: 1)),
              SizedBox(height: 30),
              AnimatedPhysicalModel(
                color: Colors.grey,
                elevation: physicalModelButton ? 1 : 8,
                shape: BoxShape.rectangle,
                shadowColor: Colors.grey,
                duration: Duration(milliseconds: 100),
                child: Listener(
                  onPointerDown: (v) => setState(() {
                    physicalModelButton = true;
                  }),
                  onPointerUp: (v) => setState(() {
                    physicalModelButton = false;
                  }),
                  child: Container(
                      color: Colors.white,
                      width: 200,
                      height: 100,
                      child: Center(child: Text("Animated Physical Model"))),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ));
  }
}
