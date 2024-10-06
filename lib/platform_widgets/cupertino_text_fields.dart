import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoTextFields extends StatefulWidget {
  const CupertinoTextFields({super.key});

  @override
  State<CupertinoTextFields> createState() => _CupertinoTextFieldsState();
}

class _CupertinoTextFieldsState extends State<CupertinoTextFields> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CupertinoFormRow(
            prefix: Text("Any other data"),
            child: Text("Any text"),
          ),
          CupertinoSearchTextField(
            controller: _textEditingController,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: CupertinoColors.inactiveGray),
            ),
            child: CupertinoTextFormFieldRow(
              prefix: const Text("Any text"),
              controller: _textEditingController,
              placeholder: "Enter text",
              decoration: BoxDecoration(
              ),
            ),
          )
        ],
      ),
    );
  }
}
