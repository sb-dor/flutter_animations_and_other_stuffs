import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';

@immutable
sealed class MainConcurrencyEvent {}

final class CounterIncrement extends MainConcurrencyEvent {}

final class CounterDecrement extends MainConcurrencyEvent {}

sealed class MainConcurrencyState {
  int coutner;

  MainConcurrencyState({required this.coutner});
}

class InitialMainConState extends MainConcurrencyState {
  InitialMainConState({required int counter}) : super(coutner: counter);
}

class MainBlocConcurrency extends Bloc<MainConcurrencyEvent, MainConcurrencyState> {
  MainBlocConcurrency() : super(InitialMainConState(counter: 0)) {
//
// the main concept of bloc_concurrency is that whenever you put the value to transform parameter of "on"
// for calling event it should do some work exactly to event

// for example: event below will work this way: when user clicks on button several times
// in order to call same event several times
// this "transformer : droppable()" will remove other clicked events of this event until first clicked event completes

// type of transformers:

    /// [ concurrent() -> process events concurrently | события обрабатываются одновременно]

    /// [ sequential() -> process events sequentially | события обрабатываются последовательно]

    /// [ droppable() -> ignore any events added while an event i.s processing | игрорирет любые события, добавленные во время обработки события]

    /// [ restartable() -> process only the latest event and cancel previous event handlers |  обрабатывает только последнее событие и отменять предыдущие обработчики событий]

    on<CounterIncrement>((event, emit) async {
      await counterIncrement(emit);
    }, transformer: restartable());

    on<CounterDecrement>((event, emit) async {
      await secondEventVoid(emit);
    }, transformer: droppable());
  }

// also you can create function sending there "emit" and do your work out of bloc
// and call you functions in "on" events
// the benefit of this is that you can change your code and do not hot-reload each time when you change your code
  Future<void> counterIncrement(Emitter<MainConcurrencyState> emit) async {
    await Future.delayed(const Duration(seconds: 3));
    var currentState = state.coutner;
    currentState++;
    emit(InitialMainConState(counter: currentState));
  }

  Future<void> secondEventVoid(Emitter<MainConcurrencyState> emit) async {
    var currentState = state.coutner;
    if(currentState <= 0) return;
    currentState--;
    emit(InitialMainConState(counter: currentState));
  }
}
