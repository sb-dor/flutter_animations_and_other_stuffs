import 'package:flutter/material.dart';
import 'package:flutter_animations_2/flutter_riverpod/all_riverpods.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlutterRiverPodPage extends ConsumerWidget {
  const FlutterRiverPodPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var counterProviderWatch = ref.watch(counterRiverPod);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Riverpod"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${counterProviderWatch.counter}"),
              TextButton(
                  onPressed: () =>
                      ref.read(counterRiverPod.notifier).increment(),
                  child: const Text("Increment")),
              GestureDetector(
                onTap: () => ref.read(counterRiverPod.notifier).changeColor(),
                child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    width: 100,
                    height: 50,
                    color: counterProviderWatch.changeColor
                        ? Colors.orange
                        : Colors.green,
                    child: const Center(child: Text("Hello"))),
              )
            ]),
      ),
    );
  }
}
