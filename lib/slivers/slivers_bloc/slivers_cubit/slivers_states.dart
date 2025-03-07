import 'package:flutter_animations_2/slivers/slivers_bloc/slivers_cubit/sliver_state_model.dart';

abstract class SliverStates {
  SliverStateModel sliverStateModel;

  SliverStates({required this.sliverStateModel});
}

class InitialSliverState extends SliverStates {
  InitialSliverState(SliverStateModel sliverStateModel) : super(sliverStateModel: sliverStateModel);
}
