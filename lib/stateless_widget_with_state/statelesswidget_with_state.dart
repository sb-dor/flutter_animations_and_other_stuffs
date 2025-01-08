import 'package:flutter/material.dart';

class StatelessWidgetWithState extends StatelessWidget {
  const StatelessWidgetWithState({super.key});

  @override
  StatelessElement createElement() => MyStatelessElement(this);

  @override
  Widget build(BuildContext context) => throw UnsupportedError('NO NEEDED WIDGET');
}

class MyStatelessElement extends StatelessElement {
  late int number;

  MyStatelessElement(super.widget);

  // initState
  @override
  void mount(Element? parent, Object? newSlot) {
    number = 1;
    super.mount(parent, newSlot);
  }

  // dispose

  // didUpdateWidget

  // setState is our own function
  void setState(VoidCallback fn) {
    fn();
    markNeedsBuild();
  }

  @override
  Widget build() => Scaffold(
        body: SizedBox.expand(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  number++;
                  setState(() {});
                },
                child: const Text("Plus"),
              ),
              Text("$number"),
              TextButton(
                  onPressed: () {
                    number--;
                    setState(() {});
                  },
                  child: const Text("Minus"))
            ],
          ),
        ),
      );
}

class TestStateFul extends StatefulWidget {
  const TestStateFul({super.key});

  @override
  State<TestStateFul> createState() => _TestStateFulState();
}

class _TestStateFulState extends State<TestStateFul> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
