import 'package:flutter/material.dart';
import 'package:flutter_animations_2/bloc_learning/using_freezed/using_freezed_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsingFreezedPage extends StatelessWidget {
  const UsingFreezedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsingFreezedBloc, UsingFreezedState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Bloc using freezed"),
        ),
        body: Center(
          child: Column(
            children: [
              IconButton(
                  onPressed: () => context.read<UsingFreezedBloc>().add(const DecrementEvent()),
                  icon: const Icon(Icons.add)),
              Text("${state.stateModel.number}"),
              IconButton(
                  onPressed: () => context.read<UsingFreezedBloc>().add(const IncrementEvent()),
                  icon: const Icon(Icons.add)),
            ],
          ),
        ),
      );
    });
  }
}
