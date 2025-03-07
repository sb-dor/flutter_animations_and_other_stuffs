import 'package:flutter/material.dart';
import 'package:flutter_animations_2/navigation/imperative_navigation/imperative_nav_second_screen.dart';

class ImperativeNavigationFirstScreen extends StatefulWidget {
  const ImperativeNavigationFirstScreen({super.key});

  @override
  State<ImperativeNavigationFirstScreen> createState() =>
      _ImperativeNavigationFirstScreenState();
}

class _ImperativeNavigationFirstScreenState
    extends State<ImperativeNavigationFirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Imperative first screen"),
      ),
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const ImperativeNavigationSecondScreen(),
                  ),
                );
              },
              child: const Text("Push to Second Screen")),
        ),
      ),
    );
  }
}
