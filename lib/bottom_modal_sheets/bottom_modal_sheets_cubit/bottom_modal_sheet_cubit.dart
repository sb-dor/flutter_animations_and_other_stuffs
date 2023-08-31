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

  void changeHeight({required BuildContext context}) async {
    var currentState = state.bottomModalSheetStateModel;
    RenderBox box =
        currentState.secondModalSheetKey.currentContext?.findRenderObject() as RenderBox;
    double pos = box.localToGlobal(Offset.zero).dy;
    double middlePos =
        MediaQuery.of(context).size.height / 3 - (MediaQuery.of(context).size.height / 4);

    if (pos >= MediaQuery.of(context).size.height / 1.6) {
      currentState.popupWorked = true;
      emit(InitialModalBottomSheetStates(currentState));
      await Future.delayed(const Duration(milliseconds: 30));
      if (context.mounted) Navigator.of(context).popUntil((route) => route.isFirst);
      Future.delayed(const Duration(milliseconds: 300), () {
        currentState.popupWorked = false;
        //do something after closing popup
      });
      return;
    }

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
