import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'flutter_testing_widgets_bloc.freezed.dart';

@freezed
class FlutterTestingWidgetsEvent with _$FlutterTestingWidgetsEvent {
  const factory FlutterTestingWidgetsEvent.changeState() = _ChangeStateOnFlutterTestingWidgetsEvent;
}

@freezed
class FlutterTestingWidgetsState with _$FlutterTestingWidgetsState {
  const factory FlutterTestingWidgetsState.completed(int test) =
      CompletedStateOnFlutterTestingWidgetsState;
}

class FlutterTestingWidgetsBloc
    extends Bloc<FlutterTestingWidgetsEvent, FlutterTestingWidgetsState> {
  FlutterTestingWidgetsBloc() : super(const FlutterTestingWidgetsState.completed(10)) {
    on<FlutterTestingWidgetsEvent>(
      (event, emit) => event.map(
        changeState: (event) => _changeState(event, emit),
      ),
    );
  }

  void _changeState(
    _ChangeStateOnFlutterTestingWidgetsEvent event,
    Emitter<FlutterTestingWidgetsState> emit,
  ) {
    var currentState = state as CompletedStateOnFlutterTestingWidgetsState;

    currentState = currentState.copyWith(test: Random().nextInt(100));

    emit(currentState);
  }
}
