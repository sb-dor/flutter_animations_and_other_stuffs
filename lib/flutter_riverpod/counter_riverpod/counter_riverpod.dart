import 'package:flutter_animations_2/flutter_riverpod/counter_riverpod/state_model/counter_state_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterRiverPod extends StateNotifier<CounterStateModel> {
  CounterRiverPod() : super(CounterStateModel());

  void increment() {
    var counterModel = state.clone();
    counterModel.counter++;
    state = counterModel;
  }

  void changeColor() {
    var currentState = state.clone();

    currentState.changeColor = !currentState.changeColor;

    state = currentState;
  }
}
