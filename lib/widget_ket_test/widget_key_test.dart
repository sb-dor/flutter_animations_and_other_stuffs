import 'package:flutter/material.dart';

class WidgetKeyTest extends StatefulWidget {
  const WidgetKeyTest({super.key});

  @override
  State<WidgetKeyTest> createState() => _WidgetKeyTestState();
}

class _WidgetKeyTestState extends State<WidgetKeyTest> {
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    debugPrint("test widget init: ${widget.key}");
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    debugPrint("test widget disposed: ${widget.key}");
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: TextField(
        controller: _textEditingController,
      ),
    );
  }
}
