import 'package:flutter/material.dart';
import 'package:flutter_animations_2/DI/example/calc_service.dart';
import 'package:flutter_animations_2/DI/example/example_view_model.dart';
import 'di_container.dart';
import 'service_locator.dart';

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
  late final DIContainer _diContainer;

  @override
  void initState() {
    super.initState();
    final calcService = FirstCalc();
    final exampleCalcVM = ExampleCalcModel(calcService);
    _diContainer = DIContainer(
      calcService: calcService,
      exampleViewModel: exampleCalcVM,
      exampleWidget: DiPage(model: exampleCalcVM),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _diContainer.exampleWidget;
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
  void initState() {
    super.initState();
    debugPrint("hashcode of calcService: ${ServiceLocator.instance.calcService.hashCode}");
    debugPrint("hashcode of calcService: ${ServiceLocator.instance.calcService.hashCode}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DI Page"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {

            },
            child: const Text("Click"),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Click 2"),
          ),
        ],
      ),
    );
  }
}
