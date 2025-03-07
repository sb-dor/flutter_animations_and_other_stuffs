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

class _OverlayAnimationState extends State<OverlayAnimation>
    with TickerProviderStateMixin {
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
    debugPrint("dropping image pos 2: ${findOffset(widget.imagePosition!)}");
    debugPrint("dropping name pos 2: ${findOffset(widget.fNamePosition!)}");

    imageOffsetTween = Tween(
      begin: widget.dadAnimationModel.imagePosition,
      end: findOffset(widget.imagePosition!),
    ).animate(
      CurvedAnimation(
        parent: animationSettings,
        curve: Curves.fastOutSlowIn,
      ),
    );

    fNameOffsetTween = Tween(
      begin: widget.dadAnimationModel.fNamePosition,
      end: findOffset(widget.fNamePosition!),
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
          type: MaterialType.transparency,
          child: Container(
            padding: const EdgeInsets.all(8),
            // do not forget to to put stack otherwise it will not work properly
            child: Stack(
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
                  child: Container(
                    child: Text(
                      "${widget.dadAnimationModel.firstName}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
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
