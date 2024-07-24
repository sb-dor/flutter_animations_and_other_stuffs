import 'package:flutter/material.dart';
import 'package:flutter_animations_2/drag_and_drop_animation/utils.dart';
import 'package:flutter_animations_2/drag_and_drop_own_animation/models/dad_animation_model.dart';
import 'package:flutter_animations_2/drag_and_drop_own_animation/overlay_animation.dart';
import 'package:flutter_animations_2/drag_and_drop_own_animation/provider/drag_and_drop_provider.dart';
import 'package:provider/provider.dart';

class DragAndDropOwnAnimation extends StatefulWidget {
  const DragAndDropOwnAnimation({super.key});

  @override
  State<DragAndDropOwnAnimation> createState() => _DragAndDropOwnAnimationState();
}

class _DragAndDropOwnAnimationState extends State<DragAndDropOwnAnimation> {
  final imageDragOffsetKey = GlobalKey();
  final fNameDragOffsetKey = GlobalKey();

  void onDragEnd(DraggableDetails drag, DADAnimationModel model) {
    if (!drag.wasAccepted) return;
    final provider = Provider.of<DragAndDropProvider>(context, listen: false);
    provider.addToList(
      model
        ..initDADAnimationOffsets(
          imagePosition: findOffset(imageDragOffsetKey),
          fNamePosition: findOffset(fNameDragOffsetKey),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dadListProvider = Provider.of<DragAndDropProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test drop down animation"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Wrap(
            children: dadListProvider.items
                .map(
                  (e) => Draggable<DADAnimationModel>(
                    key: ObjectKey(e),
                    data: e,
                    onDragEnd: (v) => onDragEnd(v, e),

                    feedback: _ReusableItemWidget(
                      key: ObjectKey(e),
                      item: e,
                      imagePosition: imageDragOffsetKey,
                      fNamePosition: fNameDragOffsetKey,
                    ),
                    childWhenDragging: const SizedBox(),
                    child: _ReusableItemWidget(
                      item: e,
                      key: UniqueKey(),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 20),
          DragTarget<DADAnimationModel>(
            builder: (context, candidateData, rejectedData) => Container(
              constraints: const BoxConstraints(minHeight: 300),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Wrap(
                children: [
                  ...dadListProvider.dadList
                      .map(
                        (e) => _ItemWidget(
                          item: e,
                        ),
                      )
                      .toList(),
                  // if (candidateData.isNotEmpty)
                  //   _ReusableItemWidget(
                  //     item: candidateData.first!,
                  //   ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ItemWidget extends StatefulWidget {
  final DADAnimationModel item;

  const _ItemWidget({
    super.key,
    required this.item,
  });

  @override
  State<_ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<_ItemWidget> {
  OverlayEntry? entry;
  bool animationEnd = false;
  GlobalKey imagePosition = GlobalKey();
  GlobalKey fNamePosition = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((v) {
      startMorphAnimation();
    });
  }

  void startMorphAnimation() {
    debugPrint("coming inside drag and drop entry ${imagePosition.currentWidget}");
    entry = OverlayEntry(
      builder: (context) {
        return OverlayAnimation(
          dadAnimationModel: widget.item,
          imagePosition: imagePosition,
          fNamePosition: fNamePosition,
          onAnimationEnd: () {
            animationEnd = true;
            entry?.remove();
            setState(() {});
          },
        );
      },
    );
    Overlay.of(context).insert(entry!);
  }

  @override
  Widget build(BuildContext context) {
    final child = Visibility(
      visible: animationEnd,
      maintainState: true,
      maintainAnimation: true,
      maintainSize: true,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Container(
                key: imagePosition,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: SizedBox(
                    width: 90,
                    height: 90,
                    child: Image.asset(
                      "assets/${widget.item.asset!}",
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                key: fNamePosition,
                child: Text(
                  "${widget.item.firstName}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return child;
  }
}

class _ReusableItemWidget extends StatelessWidget {
  final GlobalKey? imagePosition;
  final GlobalKey? fNamePosition;
  final DADAnimationModel item;

  const _ReusableItemWidget({
    super.key,
    this.imagePosition,
    this.fNamePosition,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              key: imagePosition,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: SizedBox(
                  width: 90,
                  height: 90,
                  child: Image.asset(
                    "assets/${item.asset!}",
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              key: fNamePosition,
              child: Text(
                "${item.firstName}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
