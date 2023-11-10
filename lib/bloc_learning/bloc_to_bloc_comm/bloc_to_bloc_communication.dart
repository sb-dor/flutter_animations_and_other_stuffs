import 'package:flutter/material.dart';
import 'package:flutter_animations_2/bloc_learning/bloc_to_bloc_comm/first_bloc/first_bloc.dart';
import 'package:flutter_animations_2/bloc_learning/bloc_to_bloc_comm/second_bloc/second_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocToBlocCommunication extends StatefulWidget {
  const BlocToBlocCommunication({Key? key}) : super(key: key);

  @override
  State<BlocToBlocCommunication> createState() => _BlocToBlocCommunicationState();
}

class _BlocToBlocCommunicationState extends State<BlocToBlocCommunication> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FirstBloc>().add(SimpleEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SecondBloc, SecondBlocStates>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(title: const Text("Bloc to Bloc communication")),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                "Sibling dependencies between two entities in the same architectural layer should be avoided at all costs, "
                "as it creates tight-coupling which is hard to maintain."
                " Since blocs reside in the business logic architectural layer, no bloc should know about any other bloc."),
          ),
        ),
      );
    });
  }
}
