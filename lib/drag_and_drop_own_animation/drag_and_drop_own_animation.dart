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
                    feedback: _ItemWidget(
                      item: e,
                      imagePosition: imageDragOffsetKey,
                      fNameKey: fNameDragOffsetKey,
                      animation: false,
                    ),
                    childWhenDragging: const SizedBox(),
                    child: _ItemWidget(
                      item: e,
                      key: UniqueKey(),
                      animation: false,
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
                  if (candidateData.isNotEmpty)
                    _ItemWidget(
                      item: candidateData.first!,
                      animation: false,
                    ),
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
  final GlobalKey? imagePosition;
  final GlobalKey? fNameKey;
  final bool animation;

  const _ItemWidget({
    super.key,
    required this.item,
    this.imagePosition,
    this.fNameKey,
    this.animation = true,
  });

  @override
  State<_ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<_ItemWidget> {
  bool animationEnd = false;
  OverlayEntry? entry;
  late GlobalKey imagePosition;
  late GlobalKey fNameKey;

  @override
  void initState() {
    super.initState();
    imagePosition = widget.imagePosition ?? GlobalKey();
    fNameKey = widget.fNameKey ?? GlobalKey();
  }

  void startMorphAnimation() {
    if (!widget.animation) return;
    entry = OverlayEntry(
      builder: (context) {
        return OverlayAnimation(
          dadAnimationModel: widget.item,
          imagePosition: widget.imagePosition,
          fNamePosition: widget.fNameKey,
          onAnimationEnd: () {
            animationEnd = true;
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
      visible: widget.animation ? animationEnd : true,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              ClipRRect(
                key: widget.imagePosition,
                borderRadius: BorderRadius.circular(50),
                child: SizedBox(
                  width: 90,
                  height: 90,
                  child: Image.asset(
                    "assets/${widget.item.asset!}",
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                key: widget.fNameKey,
                "${widget.item.lastName}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
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
