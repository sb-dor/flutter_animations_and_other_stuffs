import 'package:flutter/material.dart';

class SecondDecScreen extends StatefulWidget {
  const SecondDecScreen({super.key});

  @override
  State<SecondDecScreen> createState() => _SecondDecScreenState();
}

class _SecondDecScreenState extends State<SecondDecScreen> {
  int? name;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments;

    debugPrint("args is: ${args.runtimeType}");

    // assert checks the condition that should be equal (matches) to the given args
    // in this situation args should be a type of Map<String, int> otherwise it throws an error with this message
    assert(args is Map<String, int>, "Bro, your argument is not type of Map");

    if (args is Map) {
      name = args['number'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Second Dec Screen"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Pop to first dec screen -> $name"),
        ),
      ),
    );
  }
}
