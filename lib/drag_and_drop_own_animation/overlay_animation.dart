import 'package:flutter/material.dart';
import 'package:flutter_animations_2/drag_and_drop_animation/utils.dart';
import 'package:flutter_animations_2/drag_and_drop_own_animation/models/dad_animation_model.dart';

class OverlayAnimation extends StatefulWidget {
  final DADAnimationModel dadAnimationModel;
  final GlobalKey? imagePosition;
  final GlobalKey? fNamePosition;
  final VoidCallback onAnimationEnd;

  const OverlayAnimation({
    super.key,
    required this.dadAnimationModel,
    required this.imagePosition,
    required this.fNamePosition,
    required this.onAnimationEnd,
  });

  @override
  State<OverlayAnimation> createState() => _OverlayAnimationState();
}

class _OverlayAnimationState extends State<OverlayAnimation> with TickerProviderStateMixin {
  late final AnimationController animationSettings;

  late Animation<Offset> imageOffsetTween;
  late Animation<Offset> fNameOffsetTween;

  @override
  void initState() {
    super.initState();
    animationSettings = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    morph();

    animationSettings.forward().whenComplete(widget.onAnimationEnd);
  }

  @override
  void dispose() {
    animationSettings.dispose();
    super.dispose();
  }

  void morph() {
    final dragAndTargetOffset = calculateOffsets(
      widget.dadAnimationModel.imagePosition!,
      widget.imagePosition!,
    );

    final fNameDragAndTargetOffset = calculateOffsets(
      widget.dadAnimationModel.fNamePosition!,
      widget.fNamePosition!,
    );

    imageOffsetTween = Tween(
      begin: dragAndTargetOffset.$1,
      end: dragAndTargetOffset.$2,
    ).animate(
      CurvedAnimation(
        parent: animationSettings,
        curve: Curves.fastOutSlowIn,
      ),
    );

    fNameOffsetTween = Tween(
      begin: fNameDragAndTargetOffset.$1,
      end: fNameDragAndTargetOffset.$2,
    ).animate(
      CurvedAnimation(
        parent: animationSettings,
        curve: Curves.fastOutSlowIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationSettings,
      builder: (context, child) {
        return Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Transform.translate(
                  offset: imageOffsetTween.value,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: SizedBox(
                      width: 90,
                      height: 90,
                      child: Image.asset(
                        "assets/${widget.dadAnimationModel.asset!}",
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Transform.translate(
                  offset: fNameOffsetTween.value,
                  child: Text(
                    "${widget.dadAnimationModel.firstName}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
