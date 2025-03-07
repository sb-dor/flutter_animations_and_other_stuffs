import 'package:faker/faker.dart' as faker;
import 'package:flutter/material.dart';
import 'package:flutter_animations_2/animations/blur_container.dart';
import 'package:flutter_animations_2/bottom_modal_sheets/bottom_modal_sheets_cubit/bottom_modal_sheet_cubit.dart';
import 'package:flutter_animations_2/bottom_modal_sheets/bottom_modal_sheets_cubit/bottom_modal_sheets_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomModalSheetDynamicSize {
  static final fake = faker.Faker();
  //
  static bottomSheetWithSizeOfContent({required BuildContext context}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(children: [
            SizedBox(
                width: double.maxFinite,
                child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  const SizedBox(height: 10),
                  Container(
                      width: 50,
                      height: 7,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade500, borderRadius: BorderRadius.circular(8))),
                  const SizedBox(height: 10),
                  SizedBox(
                      width: double.maxFinite,
                      child: SingleChildScrollView(
                          child: Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                              child:
                                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                const SizedBox(height: 15),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: "≪",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Theme.of(context).textTheme.displayLarge?.color,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: " ${fake.lorem.sentence()} ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Theme.of(context).textTheme.displayLarge?.color,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: "≫",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Theme.of(context).textTheme.displayLarge?.color,
                                          fontWeight: FontWeight.bold))
                                ])),
                                const SizedBox(height: 10),
                                Text(fake.lorem.sentence(),
                                    style: const TextStyle(fontSize: 16), maxLines: 11),
                                const SizedBox(height: 15)
                              ]))))
                ]))
          ]);
        });
  }

  //
  static bottomSheetScrollable({required BuildContext context}) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          DraggableScrollableController controller = DraggableScrollableController();
          return DraggableScrollableSheet(
              controller: controller,
              initialChildSize: 0.7,
              builder: (BuildContext context, ScrollController scrollController) => Container(
                  color: Colors.white,
                  child: ListView(
                      controller: scrollController,
                      children: List.generate(100, (index) => Text("${index + 1}")).toList())));
        });
  }

  //
  static bottomDoubleModalSheet({required BuildContext context}) async {
    context.read<BottomModalSheetCubits>().initChangeableHeight(context: context);
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        builder: (context) =>
            BlocBuilder<BottomModalSheetCubits, BottomModalSheetStates>(builder: (context, state) {
              var currentState = state.bottomModalSheetStateModel;
              return SizedBox(
                  height: currentState.changeableHeight,
                  child: Column(children: [
                    const SizedBox(height: 50),
                    Flexible(
                        child: SizedBox(
                            width: double.maxFinite,
                            height: MediaQuery.of(context).size.height / 2.5,
                            child: Image.network(
                                "https://www.syncfusion.com/blogs/"
                                "wp-content/uploads/2019/12/"
                                "Flutter_Trends_and_Community_Updates_Social.jpg",
                                fit: BoxFit.cover)))
                  ]));
            }));
    await showModalBottomSheet(
        barrierColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          DraggableScrollableController scrollableController = DraggableScrollableController();
          scrollableController.addListener(() {
            context.read<BottomModalSheetCubits>().changeHeight(context: context);
          });
          return BlocBuilder<BottomModalSheetCubits, BottomModalSheetStates>(
              builder: (context, state) {
            var currentState = state.bottomModalSheetStateModel;
            return DraggableScrollableSheet(
                controller: scrollableController,
                initialChildSize: 0.9,
                maxChildSize: 0.9,
                expand: false,
                builder: (context, controller) {
                  return Container(
                      key: currentState.secondModalSheetKey,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ListView(
                          padding: const EdgeInsets.all(10),
                          controller: controller,
                          children: [
                            GestureDetector(
                                onHorizontalDragUpdate: (move) {
                                  if (move.delta.dx > 0) {
                                    // Dragging to the right
                                    debugPrint("Dragging to the right");
                                  } else if (move.delta.dx < 0) {
                                    // Dragging to the left
                                    debugPrint("Dragging to the left");
                                  }
                                },
                                child: Container(height: 200, color: Colors.transparent)),
                            BlurContainer(
                              child: Column(
                                  children: List.generate(
                                      100,
                                      (index) => Text(
                                            "Number: ${index + 1}",
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          )).toList()),
                            )
                          ]));
                });
          });
        }).then((value) {
      // if (modalSheetBloc.popupWorked) return;
      // Navigator.pop(context);
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    });
  }
}
