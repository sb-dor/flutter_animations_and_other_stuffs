import 'package:flutter/material.dart';
import 'package:flutter_animations_2/slivers/slivers_bloc/slivers_cubit/sliver_state_model.dart';
import 'package:flutter_animations_2/slivers/slivers_bloc/slivers_cubit/slivers_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SliverCubit extends Cubit<SliverStates> {
  SliverCubit() : super(InitialSliverState(SliverStateModel()));

  //you should initial every container after render that is why we need this func
  void initPositionsAfterRender() {
    var currentState = state.sliverStateModel;
    RenderBox blue = currentState.blueKey.currentContext?.findRenderObject() as RenderBox;
    currentState.bluePos = blue.localToGlobal(Offset.zero).dy;
    RenderBox yellow = currentState.yellowKey.currentContext?.findRenderObject() as RenderBox;
    currentState.yellowPos = yellow.localToGlobal(Offset.zero).dy;
    RenderBox pink = currentState.pinkKey.currentContext?.findRenderObject() as RenderBox;
    currentState.pinkPos = pink.localToGlobal(Offset.zero).dy;
    emit(InitialSliverState(currentState));
  }

  void horizontalAnimation({required int index}) async {
    var currentState = state.sliverStateModel;
    if (currentState.selectedIndex == index) return;
    currentState.selectedIndex = index;
    emit(InitialSliverState(currentState));
    await Future.delayed(const Duration(milliseconds: 100));
    RenderBox box =
        currentState.horizontalKeys[index].currentContext?.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero); //this is global position
    await currentState.horizontalScrollController.animateTo(position.dx,
        duration: const Duration(seconds: 1), curve: Curves.linearToEaseOut);
  }

  void position({required ScrollController scrollPosition}) async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var currentState = state.sliverStateModel;

      double scrollPos = scrollPosition.position.pixels +
          kToolbarHeight +
          55; //you should set position after appbar, 55 is persistent sliver bar

      debugPrint("scroll pos : $scrollPos");
      debugPrint("menu key: ${currentState.bluePos}");

      if (scrollPos < currentState.bluePos) {
        debugPrint("1");
        horizontalAnimation(index: 0);
      } else if (scrollPos >= currentState.bluePos && scrollPos < currentState.yellowPos) {
        horizontalAnimation(index: 1);
      } else if (scrollPos >= currentState.yellowPos && scrollPos < currentState.pinkPos) {
        horizontalAnimation(index: 2);
      } else if (scrollPos >= currentState.pinkPos) {
        horizontalAnimation(index: 3);
      }
    });
  }
}
