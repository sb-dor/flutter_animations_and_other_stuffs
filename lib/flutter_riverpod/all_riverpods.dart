import 'package:flutter_animations_2/flutter_riverpod/counter_riverpod/counter_riverpod.dart';
import 'package:flutter_animations_2/flutter_riverpod/counter_riverpod/state_model/counter_state_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
//
//create all riverPods in another file and use them.
final counterRiverPod =
    StateNotifierProvider<CounterRiverPod, CounterStateModel>(
        (ref) => CounterRiverPod());
