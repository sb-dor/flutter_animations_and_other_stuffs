import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class FirstGoRouterDevScreen extends StatefulWidget {
  const FirstGoRouterDevScreen({
    super.key,
  });

  @override
  State<FirstGoRouterDevScreen> createState() => _FirstGoRouterDevScreenState();
}

class _FirstGoRouterDevScreenState extends State<FirstGoRouterDevScreen> {
  final TextEditingController _textController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("First Dec Screen"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                controller: _textController,
                decoration: const InputDecoration(
                  hintText: "Name",
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_textController.text.isEmpty) return;
                context.goNamed(
                  'nameforsecondscreen',
                  pathParameters: <String, String>{
                    "number": _textController.text.trim(),
                  },
                );
              },
              child: const Text("Push second dec screen"),
            ),
          ],
        ),
      ),
    );
  }
}
