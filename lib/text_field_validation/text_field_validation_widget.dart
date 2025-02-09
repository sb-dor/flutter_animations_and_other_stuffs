import 'package:flutter/material.dart';

// In this widget I didn't find a solution for
// handling validation while user taps on button.
// Validation works only when user types something in textFiled but not on submit (when clicks on button)
class TextFieldValidationWidget extends StatefulWidget {
  const TextFieldValidationWidget({super.key});

  @override
  State<TextFieldValidationWidget> createState() => _TextFieldValidationWidgetState();
}

class _TextFieldValidationWidgetState extends State<TextFieldValidationWidget> {
  //
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBar(
          title: const Text("Text field validation"),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFieldValidationBuilder(
                controller: _textEditingController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Field cannot be empty";
                  }
                  if (!value.contains("@")) {
                    return "Please write your correct email address";
                  }
                  return null;
                },
                builder: (context, validator) {
                  return TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      errorText: validator,
                    ),
                  );
                },
              ),
              TextFieldValidationBuilder(
                controller: _passwordController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Field cannot be empty";
                  }
                  return null;
                },
                builder: (context, validator) {
                  return TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      errorText: validator,
                    ),
                  );
                },
              ),
              TextButton(
                onPressed: () {
                  // no solution yet
                },
                child: const Text(
                  "Submit",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// The child given to the builder should typically be part of the returned
// widget tree.
typedef TextFieldValidationBuilderWidget = Widget Function(
  BuildContext context,
  String? validator,
);

class TextFieldValidationBuilder extends StatefulWidget {
  //
  const TextFieldValidationBuilder({
    super.key,
    required this.controller,
    required this.validator,
    required this.builder,
  });

  final ValueNotifier<TextEditingValue> controller;
  final String? Function(String value) validator;
  final TextFieldValidationBuilderWidget builder;

  @override
  State<TextFieldValidationBuilder> createState() => _TextFieldValidationBuilderState();
}

class _TextFieldValidationBuilderState extends State<TextFieldValidationBuilder> {
  String? _validator;

  //
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handler);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handler);
    super.dispose();
  }

  void _handler() {
    if (!mounted) return;

    setState(() {
      _validator = widget.validator(widget.controller.value.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _validator);
  }
}
