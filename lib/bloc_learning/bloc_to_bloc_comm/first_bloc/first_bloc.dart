import 'package:flutter_bloc/flutter_bloc.dart';

abstract class FirstBlocEvents {}

class SimpleEvent extends FirstBlocEvents {}

abstract class FirstBlocStates {
  int counter;

  FirstBlocStates({required this.counter});
}

class InitState extends FirstBlocStates {
  InitState({required int counter}) : super(counter: counter);
}

class FirstBloc extends Bloc<FirstBlocEvents, FirstBlocStates> {
  FirstBloc() : super(InitState(counter: 0)) {
    //
    //
    on<SimpleEvent>((event, emit) async {
      var currentState = state.counter;
      currentState++;
      emit(InitState(counter: currentState));
      await Future.delayed(const Duration(seconds: 3));
      currentState++;
      emit(InitState(counter: currentState));
    });
  }
}
