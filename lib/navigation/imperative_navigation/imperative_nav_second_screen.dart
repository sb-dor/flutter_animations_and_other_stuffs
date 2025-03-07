import 'package:flutter/material.dart';

class ImperativeNavigationSecondScreen extends StatefulWidget {
  const ImperativeNavigationSecondScreen({super.key});

  @override
  State<ImperativeNavigationSecondScreen> createState() =>
      _ImperativeNavigationSecondScreenState();
}

class _ImperativeNavigationSecondScreenState
    extends State<ImperativeNavigationSecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Imperative second screen"),
      ),
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Pop to First Screen")),
        ),
      ),
    );
  }
}
