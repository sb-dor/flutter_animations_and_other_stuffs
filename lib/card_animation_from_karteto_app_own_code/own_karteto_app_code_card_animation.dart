import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animations_2/drag_and_drop_animation/utils.dart';
import 'package:flutter_animations_2/global_context/global_context.helper.dart';

import 'own_karteto_cards.dart';

const double _cardHeight = 400;
const double _cardWidth = 300;

class OwnKartetoAppCodeCardAnimation extends StatefulWidget {
  const OwnKartetoAppCodeCardAnimation({super.key});

  @override
  State<OwnKartetoAppCodeCardAnimation> createState() => _OwnKartetoAppCodeCardAnimationState();
}

class _OwnKartetoAppCodeCardAnimationState extends State<OwnKartetoAppCodeCardAnimation> {
  final rnd = Random();

  final List<Color> _colorsForBackGround = [
    Colors.brown.shade50,
    Colors.red.shade50,
    Colors.blue.shade50,
    Colors.amber.shade50,
  ];

  final List<OwnKartetoCards> _cards = [...OwnKartetoCards.cards];

  void onTargetTouch() {
    if (_cards.isNotEmpty) {
      _cards.removeAt(0);
    }
    setState(() {});
  }

  void refreshList() {
    _cards.clear();
    _cards.addAll(OwnKartetoCards.cards);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade50,
      appBar: AppBar(
        backgroundColor: Colors.brown.shade50,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Stack(
                      children: _cards
                          .asMap()
                          .entries
                          .map(
                            (e) => _CardWidget(
                              ownKartetoCards: e.value,
                              index: e.key,
                              onDragEnd: () => onTargetTouch(),
                            ),
                          )
                          .toList()
                          .reversed
                          .toList(),
                    ),
                  ),
                  Positioned.fill(
                    right: MediaQuery.of(context).size.width / 1.2,
                    child: DragTarget(
                      builder: (context, objects, data) {
                        return Container(
                          color: Colors.transparent,
                        );
                      },
                    ),
                  ),
                  Positioned.fill(
                    left: MediaQuery.of(context).size.width / 1.2,
                    child: DragTarget(
                      builder: (context, objects, data) {
                        return Container(
                          color: Colors.transparent,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      refreshList();
                    },
                    icon: const Icon(Icons.refresh)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.volume_down)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CardWidget extends StatefulWidget {
  final OwnKartetoCards ownKartetoCards;
  final int index;
  final VoidCallback onDragEnd;

  const _CardWidget({
    super.key,
    required this.ownKartetoCards,
    required this.index,
    required this.onDragEnd,
  });

  @override
  State<_CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<_CardWidget> {
  final dragStartPos = GlobalKey();

  void _onDragEnd(DraggableDetails details) {
    if (details.wasAccepted) {
      widget.ownKartetoCards.lastOffset = null;
      widget.onDragEnd();
      return;
    }
    widget.ownKartetoCards.initOffset(
      offset: findOffset(dragStartPos),
    );
    debugPrint("coming here ?: ${findOffset(dragStartPos)}");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(seconds: 1),
      curve: Curves.bounceInOut,
      left: 0,
      right: 0,
      bottom: widget.index >= 3 ? 70 : 0,
      top: widget.index >= 3 ? 100 : widget.index * 25,
      child: Center(
        child: Draggable<OwnKartetoCards>(
          key: ObjectKey(widget.ownKartetoCards),
          data: widget.ownKartetoCards,
          childWhenDragging: const SizedBox(),
          onDragEnd: (v) => _onDragEnd(v),
          feedback: _DragWidget(
            ownKartetoCards: widget.ownKartetoCards,
            index: widget.index,
            dragStart: dragStartPos,
            startAnimate: false,
          ),
          child: _DragWidget(
            ownKartetoCards: widget.ownKartetoCards,
            index: widget.index,
            key: UniqueKey(),
          ),
        ),
      ),
    );
  }
}

class _DragWidget extends StatefulWidget {
  final OwnKartetoCards ownKartetoCards;
  final int index;
  final GlobalKey? dragStart;
  final bool startAnimate;

  const _DragWidget({
    super.key,
    required this.ownKartetoCards,
    required this.index,
    this.dragStart,
    this.startAnimate = true,
  });

  @override
  State<_DragWidget> createState() => _DragWidgetState();
}

class _DragWidgetState extends State<_DragWidget> {
  // final globalContext = GlobalContextHelper.instance.globalNavigatorContext.currentContext!;
  bool showWidget = true;

  OverlayEntry? overlay;
  late final GlobalKey widgetKey;

  @override
  void initState() {
    super.initState();
    widgetKey = widget.dragStart ?? GlobalKey();
    if (widget.ownKartetoCards.lastOffset != null && widget.startAnimate) {
      showWidget = false;
      setState(() {});
    }
    Future.delayed(const Duration(milliseconds: 1), () {
      startAnimation();
    });
    // WidgetsBinding.instance.addPostFrameCallback((s) {
    // });
  }

  void startAnimation() {
    if (widget.ownKartetoCards.lastOffset != null && widget.startAnimate) {
      overlay = OverlayEntry(builder: (context) {
        return _OverlayOfAnimation(
          ownKartetoCards: widget.ownKartetoCards,
          endPositionOfWidget: widgetKey,
          onEndAnimation: () => onEndAnimation(),
        );
      });
      Overlay.of(context).insert(overlay!);
    }
  }

  void onEndAnimation() {
    overlay?.remove();
    overlay = null;
    showWidget = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      maintainState: true,
      maintainAnimation: true,
      maintainSize: true,
      visible: showWidget,
      child: SizedBox(
        key: widgetKey,
        width: _cardWidth,
        height: _cardHeight,
        child: AnimatedPadding(
          padding: EdgeInsets.symmetric(horizontal: widget.index * 20),
          duration: const Duration(milliseconds: 300),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 2,
                  offset: const Offset(2, 2),
                ),
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 2,
                  offset: const Offset(-2, -2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OverlayOfAnimation extends StatefulWidget {
  final OwnKartetoCards ownKartetoCards;
  final GlobalKey endPositionOfWidget;
  final VoidCallback onEndAnimation;

  const _OverlayOfAnimation({
    super.key,
    required this.ownKartetoCards,
    required this.endPositionOfWidget,
    required this.onEndAnimation,
  });

  @override
  State<_OverlayOfAnimation> createState() => _OverlayOfAnimationState();
}

class _OverlayOfAnimationState extends State<_OverlayOfAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  late final Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<Offset>(
      begin: widget.ownKartetoCards.lastOffset,
      end: findOffset(widget.endPositionOfWidget),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    _animationController.forward().whenComplete(widget.onEndAnimation);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Stack(
          children: [
            Transform.translate(
              offset: _animation.value,
              child: SizedBox(
                width: _cardWidth,
                height: _cardHeight,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 2,
                        offset: const Offset(2, 2),
                      ),
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 2,
                        offset: const Offset(-2, -2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
