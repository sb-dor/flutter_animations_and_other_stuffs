import 'dart:math';

import 'package:flutter/material.dart';

class FlutterTestingWidgetLifecycleWithSetState extends StatefulWidget {
  const FlutterTestingWidgetLifecycleWithSetState({super.key});

  @override
  State<FlutterTestingWidgetLifecycleWithSetState> createState() =>
      _FlutterTestingWidgetLifecycleWithSetStateState();
}

class _FlutterTestingWidgetLifecycleWithSetStateState
    extends State<FlutterTestingWidgetLifecycleWithSetState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Testing setState"),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              setState(() {});
            },
            child: const Text("Refresh"),
          ),
          // it will change
          const _TestRandom(),
          // it will not change
          const _TestRandom(),
        ],
      ),
    );
  }
}

class _TestRandom extends StatelessWidget {
  const _TestRandom();

  @override
  Widget build(BuildContext context) {
    return Text("${Random().nextInt(100)}");
  }
}
