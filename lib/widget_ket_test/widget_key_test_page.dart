import 'package:flutter/material.dart';
import 'package:flutter_animations_2/widget_ket_test/widget_key_test.dart';
import 'package:uuid/uuid.dart';

class WidgetKeyTestPage extends StatefulWidget {
  const WidgetKeyTestPage({super.key});

  @override
  State<WidgetKeyTestPage> createState() => _WidgetKeyTestPageState();
}

class _WidgetKeyTestPageState extends State<WidgetKeyTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test widget keys on state change"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {}),
        child: const Icon(
          Icons.change_circle,
        ),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return WidgetKeyTest(
            key: ValueKey(const Uuid().v4()),
          );
        },
      ),
    );
  }
}
