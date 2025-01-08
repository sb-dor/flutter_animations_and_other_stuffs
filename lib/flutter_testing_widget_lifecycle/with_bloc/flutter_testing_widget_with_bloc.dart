import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animations_2/flutter_testing_widget_lifecycle/with_bloc/bloc/flutter_testing_widgets_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlutterTestingWidgetWithBloc extends StatelessWidget {
  const FlutterTestingWidgetWithBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FlutterTestingWidgetsBloc(),
      child: const _FlutterTestingWithBlocUI(),
    );
  }
}

class _FlutterTestingWithBlocUI extends StatefulWidget {
  const _FlutterTestingWithBlocUI({super.key});

  @override
  State<_FlutterTestingWithBlocUI> createState() => _FlutterTestingWithBlocUIState();
}

class _FlutterTestingWithBlocUIState extends State<_FlutterTestingWithBlocUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bloc changes"),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              context
                  .read<FlutterTestingWidgetsBloc>()
                  .add(const FlutterTestingWidgetsEvent.changeState());
            },
            child: const Text(
              "Change state",
            ),
          ),
          BlocBuilder<FlutterTestingWidgetsBloc, FlutterTestingWidgetsState>(
            builder: (context, state) {
              return Column(
                children: [
                  // it doesn't matter whether you widget using const, it will change if widget has bloc inside
                  // that changes state
                  const _TestBloc(),
                  // it will not change
                  const _TestRandom(),
                  // it will change
                  Text("${state.test}"),
                ],
              );
            },
          ),
          // it will not change
          const _TestRandom(),
          // if any function calls setState it will change otherwise it will not update
          // the state
          _TestRandom(),
        ],
      ),
    );
  }
}

class _TestRandom extends StatelessWidget {
  const _TestRandom();

  @override
  Widget build(BuildContext context) {
    return Text("${Random().nextInt(100)}");
  }
}

class _TestBloc extends StatelessWidget {
  const _TestBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlutterTestingWidgetsBloc, FlutterTestingWidgetsState>(
      builder: (context, state) {
        return Text("${state.test}");
      },
    );
  }
}
