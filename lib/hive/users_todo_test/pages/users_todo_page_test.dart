import 'package:flutter/material.dart';

class UsersTodoPageTest extends StatefulWidget {
  const UsersTodoPageTest({super.key});

  @override
  State<UsersTodoPageTest> createState() => _UsersTodoPageTestState();
}

class _UsersTodoPageTestState extends State<UsersTodoPageTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users todo"),
      ),
    );
  }
}
