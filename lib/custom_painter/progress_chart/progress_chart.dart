import 'package:flutter/material.dart';

class ProgressChart extends StatefulWidget {
  const ProgressChart({super.key});

  @override
  State<ProgressChart> createState() => _ProgressChartState();
}

class _ProgressChartState extends State<ProgressChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Progress bar"),
      ),
    );
  }
}
