import 'package:flutter_animations_2/bottom_modal_sheets/bottom_modal_sheets_cubit/state_model/bottom_modal_sheet_state_model.dart';

abstract class BottomModalSheetStates {
  BottomModalSheetStateModel bottomModalSheetStateModel;

  BottomModalSheetStates({required this.bottomModalSheetStateModel});
}

class InitialModalBottomSheetStates extends BottomModalSheetStates {
  InitialModalBottomSheetStates(
      BottomModalSheetStateModel bottomModalSheetStateModel)
      : super(bottomModalSheetStateModel: bottomModalSheetStateModel);
}
