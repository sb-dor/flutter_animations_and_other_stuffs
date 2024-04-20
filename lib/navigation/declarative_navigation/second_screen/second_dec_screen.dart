import 'package:flutter/material.dart';

class SecondDecScreen extends StatefulWidget {
  const SecondDecScreen({super.key});

  @override
  State<SecondDecScreen> createState() => _SecondDecScreenState();
}

class _SecondDecScreenState extends State<SecondDecScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Second Dec Screen"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Pop to first dec screen"),
        ),
      ),
    );
  }
}
