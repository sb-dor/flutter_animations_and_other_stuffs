import 'package:flutter/material.dart';
import 'package:flutter_animations_2/bloc_learning/bloc_concurrency/main_bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaiNBlocConcurrencyPage extends StatefulWidget {
  const MaiNBlocConcurrencyPage({super.key});

  @override
  State<MaiNBlocConcurrencyPage> createState() =>
      _MaiNBlocConcurrencyPageState();
}

class _MaiNBlocConcurrencyPageState extends State<MaiNBlocConcurrencyPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBlocConcurrency, MainConcurrencyState>(
        builder: (context, state) {
      var currentState = state.coutner;
      return Scaffold(
        appBar: AppBar(title: const Text("Main Bloc Concurrency Page")),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () => context
                        .read<MainBlocConcurrency>()
                        .add(CounterIncrement()),
                    child: const Text("Increment")),
                Text("$currentState"),
                TextButton(
                    onPressed: () => context
                        .read<MainBlocConcurrency>()
                        .add(CounterDecrement()),
                    child: const Text("Decrement")),
              ]),
        ),
      );
    });
  }
}
