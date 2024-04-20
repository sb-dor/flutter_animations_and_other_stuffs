import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FirstDecScreen extends StatefulWidget {
  const FirstDecScreen({super.key});

  @override
  State<FirstDecScreen> createState() => _FirstDecScreenState();
}

class _FirstDecScreenState extends State<FirstDecScreen> {
  final TextEditingController _textController = TextEditingController();

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
              onPressed: () => Navigator.pushNamed(
                context,
                "/second/screen",
                arguments: <String, int>{
                  "number": int.parse(_textController.text.trim()),
                },
              ),
              child: const Text("Push second dec screen"),
            ),
          ],
        ),
      ),
    );
  }
}
