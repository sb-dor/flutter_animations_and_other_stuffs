import 'package:flutter/cupertino.dart';

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
          const SizedBox(height: 10),
          CupertinoSearchTextField(
            controller: _textEditingController,
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: CupertinoColors.inactiveGray),
            ),
            child: CupertinoTextFormFieldRow(
              prefix: const Text("Any text"),
              controller: _textEditingController,
              placeholder: "Enter text",
              decoration: const BoxDecoration(),
            ),
          ),
          const SizedBox(height: 10),
          CupertinoTextField(
            controller: _textEditingController,
            placeholder: "Enter text",
          )
        ],
      ),
    );
  }
}
