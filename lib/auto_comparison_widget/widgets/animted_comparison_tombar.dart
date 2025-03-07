import 'package:flutter/material.dart';
import 'package:flutter_animations_2/auto_comparison_widget/controllers/auto_comparison_controller.dart';
import 'package:flutter_animations_2/auto_comparison_widget/controllers/auto_comparison_topbar_controller.dart';
import 'package:flutter_animations_2/auto_comparison_widget/models/listview_model.dart';
import 'package:flutter_animations_2/widgets/text_widget.dart';

const animatedTopBarHeight = 60.0;

class AnimatedComparisonTopBar extends StatefulWidget {
  const AnimatedComparisonTopBar({
    super.key,
    required this.autoComparisonController,
    required this.autoComparisonTopBarController,
    required this.comparison,
    required this.index,
    required this.screenWidth,
  });

  final AutoComparisonController autoComparisonController;
  final AutoComparisonTopBarController autoComparisonTopBarController;
  final ListViewModel comparison;

  final int index;
  final double screenWidth;

  @override
  State<AnimatedComparisonTopBar> createState() =>
      _AnimatedComparisonTopBarState();
}

class _AnimatedComparisonTopBarState extends State<AnimatedComparisonTopBar> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        widget.autoComparisonController,
        widget.autoComparisonTopBarController,
      ]),
      builder: (context, child) {
        final widgetWidth = widget.screenWidth * 0.5;
        double pos = (5 + widgetWidth * widget.index);
        pos = pos -
            (widgetWidth * widget.autoComparisonTopBarController.pageOffset);
        return AnimatedPositioned(
          top: widget.autoComparisonController.showAnimatedTopBar
              ? 0
              : -animatedTopBarHeight,
          left: pos,
          duration: widget.autoComparisonController.startedToScrollPageView
              ? Duration.zero
              : const Duration(milliseconds: 175),
          curve: Curves.linear,
          height: animatedTopBarHeight,
          width: widget.screenWidth * 0.5,
          child: child!,
        );
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              offset: const Offset(0, 0.5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            spacing: 10,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: const SizedBox(
                  width: 40,
                  height: 40,
                  child: Placeholder(),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: widget.comparison.price,
                      maxLines: 1,
                      overFlow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.comparison.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
