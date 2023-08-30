import 'package:flutter/material.dart';
import 'package:flutter_animations_2/bottom_modal_sheets/bottom_modal_sheets_cubit/bottom_modal_sheets_states.dart';
import 'package:flutter_animations_2/bottom_modal_sheets/bottom_modal_sheets_cubit/state_model/bottom_modal_sheet_state_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomModalSheetCubits extends Cubit<BottomModalSheetStates> {
  BottomModalSheetCubits() : super(InitialModalBottomSheetStates(BottomModalSheetStateModel()));

  void initChangeableHeight({required BuildContext context}) {
    var currentState = state.bottomModalSheetStateModel;

    currentState.changeableHeight = MediaQuery.of(context).size.height;

    emit(InitialModalBottomSheetStates(currentState));
  }

  void changeHeight({required BuildContext context}) {
    var currentState = state.bottomModalSheetStateModel;
    RenderBox box =
        currentState.secondModalSheetKey.currentContext?.findRenderObject() as RenderBox;
    double pos = box.localToGlobal(Offset.zero).dy;
    double middlePos = MediaQuery.of(context).size.height / 3;

    if (pos >= middlePos) {
      double res = pos - middlePos;
      currentState.changeableHeight = MediaQuery.of(context).size.height - res;
      emit(InitialModalBottomSheetStates(currentState));
      return;
    }
    if (currentState.changeableHeight < MediaQuery.of(context).size.height) {
      currentState.changeableHeight = MediaQuery.of(context).size.height;
    }
    emit(InitialModalBottomSheetStates(currentState));
  }
}
