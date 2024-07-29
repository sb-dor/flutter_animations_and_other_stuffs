import 'dart:ffi';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animations_2/drag_and_drop_animation/utils.dart';

import 'own_karteto_cards.dart';

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

  List<OwnKartetoCards> get _getOnlyLastThree {
    if (_cards.length >= 3) return _cards.take(3).toList();
    return _cards;
  }

  void onTargetTouch() {
    if (_cards.isNotEmpty) {
      _cards.removeLast();
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
                children: _getOnlyLastThree
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
      //
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
      left: 0,
      right: 0,
      top: widget.index * 25,
      bottom: 0,
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
  bool showWidget = true;
  double? _cardHeight;
  double? _cardWidth;
  OverlayEntry? overlay;
  late final GlobalKey widgetKey;

  @override
  void initState() {
    super.initState();
    widgetKey = widget.dragStart ?? GlobalKey();
    WidgetsBinding.instance.addPostFrameCallback((s) {
      _cardHeight = 500;
      _cardWidth = MediaQuery.of(context).size.width / 1.3;
      setState(() {});

      startAnimation();
    });
  }

  void startAnimation() {
    if (widget.ownKartetoCards.lastOffset != null && widget.startAnimate) {
      showWidget = false;
      setState(() {});
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
        return Material(
          type: MaterialType.transparency,
          child: Stack(
            children: [
              Transform.translate(
                offset: _animation.value,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.3,
                  height: 500,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
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
              ),
            ],
          ),
        );
      },
    );
  }
}
