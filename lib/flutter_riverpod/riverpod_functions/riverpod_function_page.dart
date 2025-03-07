import 'package:flutter/material.dart';
import 'package:flutter_animations_2/flutter_riverpod/riverpod_functions/riverpod_function_state/riverpod_function_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RiverpodFunctionPage extends ConsumerWidget {
  const RiverpodFunctionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final riverpodFunction = ref.watch(triviaProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riverpod functions"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            riverpodFunction.when(
              data: (data) => Column(
                children: [
                  Text(
                    "Name: ${data.text}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text("Number: ${riverpodFunction.value?.number ?? '-'}"),
                  const SizedBox(height: 20),
                ],
              ),
              error: (error, stacktrace) => const Text("Error occreed, please try again later"),
              loading: () => const CircularProgressIndicator(),
            ),
            ElevatedButton(
              onPressed: () {
                // for function "riverpod"
                // in order recall function
                // you have to use the code below

                // whenever user try to click button several times
                // "ref.invalidate(anyProvider)" will work only once
                ref.invalidate(triviaProvider);
              },
              child: const Text(
                "Find Trivia",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
