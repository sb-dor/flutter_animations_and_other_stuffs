import 'package:flutter/material.dart';

final class TextFieldValidationNotifier with ChangeNotifier {
  //
  TextFieldValidationNotifier({
    required final TextEditingController emailController,
    required final TextEditingController passwordController,
  })  : _emailController = emailController,
        _passwordController = passwordController {
    _emailController.addListener(_emailValidator);
    _passwordController.addListener(_passwordValidator);
  }

  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  String? emailError;
  String? passwordError;

  void _emailValidator() {
    if (_emailController.text.trim().isEmpty) {
      emailError = "Field cannot be empty";
    } else if (!_emailController.text.trim().contains("@")) {
      emailError = "Please write your correct email address";
    } else {
      emailError = null;
    }
    notifyListeners();
  }

  void _passwordValidator() {
    if (_passwordController.text.trim().isEmpty) {
      passwordError = "Field cannot be empty";
    } else {
      passwordError = null;
    }
    notifyListeners();
  }

  bool validate() {
    _emailValidator();
    _passwordValidator();
    if (emailError != null || passwordError != null) return false;
    return true;
  }

  @override
  void dispose() {
    _emailController.removeListener(_emailValidator);
    _passwordController.removeListener(_passwordValidator);
    super.dispose();
  }
}

class TextFieldValidationWithChangeNotifier extends StatefulWidget {
  const TextFieldValidationWithChangeNotifier({super.key});

  @override
  State<TextFieldValidationWithChangeNotifier> createState() =>
      _TextFieldValidationWithChangeNotifierState();
}

class _TextFieldValidationWithChangeNotifierState
    extends State<TextFieldValidationWithChangeNotifier> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late final TextFieldValidationNotifier _textFieldValidationNotifier;

  @override
  void initState() {
    super.initState();
    _textFieldValidationNotifier = TextFieldValidationNotifier(
      emailController: _emailController,
      passwordController: _passwordController,
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test with change notifier"),
      ),
      body: Column(
        children: [
          ListenableBuilder(
            listenable: _textFieldValidationNotifier,
            builder: (context, child) {
              return TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  errorText: _textFieldValidationNotifier.emailError,
                ),
              );
            },
          ),
          ListenableBuilder(
            listenable: _textFieldValidationNotifier,
            builder: (context, child) {
              return TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  errorText: _textFieldValidationNotifier.passwordError,
                ),
              );
            },
          ),
          TextButton(
            onPressed: () {
              final validate = _textFieldValidationNotifier.validate();
              if (!validate) return;
              print("after validation");
            },
            child: const Text(
              "Submit",
            ),
          ),
        ],
      ),
    );
  }
}
