import 'package:flutter/material.dart';
import 'package:flutter_animations_2/DI/di_container.dart';
import 'package:flutter_animations_2/DI/example_view_model.dart';

//

class MainDIPage extends StatefulWidget {
  const MainDIPage({super.key});

  @override
  State<MainDIPage> createState() => _MainDIPageState();
}

class _MainDIPageState extends State<MainDIPage> {
  // DI container
  // get DI container without passing data through container
  // you have already set all necessary dependencies in DI container
  // now you can use that without writing bunch of code
  final _diContainer = DIContainer();

  @override
  Widget build(BuildContext context) {
    return _diContainer.exampleWidget();
  }
}

class DiPage extends StatefulWidget {
  final ExampleViewModel model;

  const DiPage({
    super.key,
    required this.model, // dependency injection
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
