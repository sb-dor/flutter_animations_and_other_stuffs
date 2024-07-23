import 'package:flutter/material.dart';
import 'package:flutter_animations_2/drag_and_drop_animation/utils.dart';
import 'package:flutter_animations_2/drag_and_drop_own_animation/models/dad_animation_model.dart';
import 'package:flutter_animations_2/drag_and_drop_own_animation/provider/drag_and_drop_provider.dart';
import 'package:provider/provider.dart';

class DragAndDropOwnAnimation extends StatefulWidget {
  const DragAndDropOwnAnimation({super.key});

  @override
  State<DragAndDropOwnAnimation> createState() => _DragAndDropOwnAnimationState();
}

class _DragAndDropOwnAnimationState extends State<DragAndDropOwnAnimation> {
  final positionDragOffsetKey = GlobalKey();
  final fNameDragOffsetKey = GlobalKey();
  final lNameDragOffsetKey = GlobalKey();
  final imageDragOffsetKey = GlobalKey();
  final moneyDragOffsetKey = GlobalKey();

  void onDragEnd(DraggableDetails data, DADAnimationModel model) {
    final provider = Provider.of<DragAndDropProvider>(context, listen: false);
    provider.addToList(
      model
        ..initDADAnimationOffsets(
          position: findOffset(positionDragOffsetKey),
          fNamePosition: findOffset(fNameDragOffsetKey),
          lNamePosition: findOffset(lNameDragOffsetKey),
          imageOffSet: findOffset(imageDragOffsetKey),
          moneyOffSet: findOffset(moneyDragOffsetKey),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test drop down animation"),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          Wrap(
            children: dadAnimationModels
                .map(
                  (e) => Draggable<DADAnimationModel>(
                    onDragEnd: (v) => onDragEnd(v, e),
                    feedback: _ItemWidget(
                      item: e,
                      positionKey: positionDragOffsetKey,
                      fNameKey: fNameDragOffsetKey,
                      lNameKey: lNameDragOffsetKey,
                      imageKey: imageDragOffsetKey,
                      moneyKey: moneyDragOffsetKey,
                      feedBackWidget: true,
                    ),
                    child: _ItemWidget(item: e),
                  ),
                )
                .toList(),
          ),
          SizedBox(height: 20),
          DragTarget<DADAnimationModel>(
            builder: (context, candidateData, rejectedData) => Container(
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: candidateData.isEmpty
                  ? Center(child: Text("Drop data"))
                  : Text("${candidateData.first?.fNamePosition}"),
            ),
          )
        ],
      ),
    );
  }
}

class _ItemWidget extends StatefulWidget {
  final DADAnimationModel item;
  final GlobalKey? positionKey;
  final GlobalKey? fNameKey;
  final GlobalKey? lNameKey;
  final GlobalKey? imageKey;
  final GlobalKey? moneyKey;
  final bool feedBackWidget;

  const _ItemWidget({
    super.key,
    required this.item,
    this.positionKey,
    this.fNameKey,
    this.lNameKey,
    this.imageKey,
    this.moneyKey,
    this.feedBackWidget = false,
  });

  @override
  State<_ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<_ItemWidget> {
  late GlobalKey positionKey;
  late GlobalKey fNameKey;
  late GlobalKey lNameKey;
  late GlobalKey imageKey;
  late GlobalKey moneyKey;

  @override
  void initState() {
    super.initState();
    positionKey = widget.positionKey ?? GlobalKey();
    fNameKey = widget.fNameKey ?? GlobalKey();
    lNameKey = widget.lNameKey ?? GlobalKey();
    imageKey = widget.imageKey ?? GlobalKey();
    moneyKey = widget.moneyKey ?? GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    final child = Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: SizedBox(
              width: 90,
              height: 90,
              child: Image.asset(
                "assets/${widget.item.asset!}",
              ),
            ),
          ),
        ],
      ),
    );
    return child;
  }
}
