import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'using_freezed_bloc.freezed.dart';

class UsingFreezedBloc extends Bloc<UsingFreezedEvents, UsingFreezedState> {
  //
  late UsingFreezedStateModel _currentState;

  //

  UsingFreezedBloc() : super(UsingFreezedState(UsingFreezedStateModel())) {
    _currentState = state.stateModel;

    on<UsingFreezedEvents>(
      (event, emit) => event.map(
        decrement: (DecrementEvent e) => _decrement(e, emit),
        increment: (IncrementEvent e) => _increment(e, emit),
      ),
    );
  }

  void _decrement(
    DecrementEvent event,
    Emitter<UsingFreezedState> emit,
  ) {
    _currentState.number++;
    emit(state.copyWith(stateModel: _currentState));
  }

  void _increment(
    IncrementEvent event,
    Emitter<UsingFreezedState> emit,
  ) {
    _currentState.number++;
    emit(state.copyWith(stateModel: _currentState));
  }
}

class UsingFreezedStateModel {
  int number = 0;
}

@Freezed()
class UsingFreezedEvents with _$UsingFreezedEvents {
  const factory UsingFreezedEvents.decrement() = DecrementEvent;

  const factory UsingFreezedEvents.increment() = IncrementEvent;
}

@Freezed()
class UsingFreezedState with _$UsingFreezedState {
  const factory UsingFreezedState(UsingFreezedStateModel stateModel) =
      _UsingFreezedState;
}
