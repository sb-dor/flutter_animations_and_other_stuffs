import 'package:flutter/material.dart';

abstract class ExampleViewModel {
  void onPressMe1();

  void onPressMe2();
}

class ExampleCalcModel implements ExampleViewModel {
  @override
  void onPressMe1() {
    print(1 + 3);
  }

  @override
  void onPressMe2() {
    print(4);
  }
}

class ExamplePetModel implements ExampleViewModel {
  @override
  void onPressMe1() {
    print("barking");
  }

  @override
  void onPressMe2() {
    print("miyayu miyayu");
  }
}

//

class DiPage extends StatefulWidget {
  final ExampleViewModel model;

  const DiPage({
    super.key,
    required this.model,
  });

  @override
  State<DiPage> createState() => _DiPageState();
}

class _DiPageState extends State<DiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DI Page"),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
