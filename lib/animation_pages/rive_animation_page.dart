import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rive/rive.dart';

class RiveAnimationPage extends StatefulWidget {
  const RiveAnimationPage({super.key});

  @override
  State<RiveAnimationPage> createState() => _RiveAnimationPageState();
}

class _RiveAnimationPageState extends State<RiveAnimationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor('#eb3a60'),
        body: const Stack(
          children: [
            Center(child: RiveAnimation.asset('rives/vehicles.riv')),
            Positioned(
                bottom: 10,
                left: 5,
                child: Column(children: [
                  Text("Welcome to Animations",
                      style: TextStyle(color: Colors.white, fontSize: 20))
                ]))
          ],
        ));
  }
}
