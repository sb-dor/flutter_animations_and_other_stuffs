import 'package:flutter/material.dart';
import 'package:flutter_animations_2/design_templates/clean_architecture/data/repository/day_data_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/day_cubit.dart';
import 'cubit/day_states.dart';

class CleanArchitecturePage extends StatefulWidget {
  const CleanArchitecturePage({super.key});

  @override
  State<CleanArchitecturePage> createState() => _CleanArchitecturePageState();
}

class _CleanArchitecturePageState extends State<CleanArchitecturePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<DayCubit>().getDataFromApi(repository: DayDataRepository());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DayCubit, DayStates>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: const Text("Clean architecture screen"),
        ),
        body: RefreshIndicator(
          onRefresh: () async =>
              context.read<DayCubit>().getDataFromApi(repository: DayDataRepository()),
          child: ListView(
            children: [
              if (state is LoadingDayState)
                const Center(child: CircularProgressIndicator())
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("${state.day?.sunrise.toString()}"),
                    Text("${state.day?.sunset.toString()}"),
                  ],
                )
            ],
          ),
        ),
      );
    });
  }
}
