import 'package:flutter/material.dart';

class FirstDecScreen extends StatefulWidget {
  const FirstDecScreen({super.key});

  @override
  State<FirstDecScreen> createState() => _FirstDecScreenState();
}

class _FirstDecScreenState extends State<FirstDecScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("First Dec Screen"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, "/second/screen"),
          child: const Text("Push second dec screen"),
        ),
      ),
    );
  }
}
