import 'package:flutter/material.dart';

class ThirdGoRouterDecScreen extends StatefulWidget {
  final int id;

  const ThirdGoRouterDecScreen({super.key, required this.id});

  @override
  State<ThirdGoRouterDecScreen> createState() => _ThirdGoRouterDecScreenState();
}

class _ThirdGoRouterDecScreenState extends State<ThirdGoRouterDecScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OK BL"),
        backgroundColor: Colors.brown,
      ),
      body: Center(
        child: Text(
          "YAHAY BL -> ID: ${widget.id}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
