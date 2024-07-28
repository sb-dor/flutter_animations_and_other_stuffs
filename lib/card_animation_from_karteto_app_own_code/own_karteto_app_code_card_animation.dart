import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';

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
              child: DragTarget(
                builder: (
                  BuildContext context,
                  List<Object?> candidateData,
                  List<dynamic> rejectedData,
                ) {
                  return Stack(
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
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      refreshList();
                    },
                    icon: Icon(Icons.refresh)),
                IconButton(onPressed: () {}, icon: Icon(Icons.volume_down)),
                IconButton(onPressed: () {}, icon: Icon(Icons.edit))
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
  bool drag = false;
  double? _cardHeight;
  double? _cardWidth;

  double _posX = 0.0;
  double _posY = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((s) {
      _cardHeight = 500;
      _cardWidth = MediaQuery.of(context).size.width / 1.3;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: drag ? Duration.zero : const Duration(milliseconds: 350),
      // bottom: 0,
      // left: 0,
      left: _posX,
      top: (widget.index * 20) + _posY,
      // duration: const Duration(seconds: 3),
      child: GestureDetector(
        onPanUpdate: (details) {
          if (!drag) drag = true;
          setState(() {
            _posX += details.delta.dx;
            _posY += details.delta.dy;
          });
        },
        onPanEnd: (details) {
          if(drag) drag = false;
          final screenSize = MediaQuery.of(context).size;
          final cardWidth = screenSize.width / 1.3;
          final cardHeight = 500.0;

          if (_posX.abs() > screenSize.width / 2 - cardWidth / 2 ||
              _posY.abs() > screenSize.height / 2 - cardHeight / 2) {
            widget.onDragEnd();
          } else {
            _posX = 0.0;
            _posY = 0.0;
            setState(() {});
          }
        },
        child: SizedBox(
          width: _cardWidth,
          height: _cardHeight,
          child: AnimatedPadding(
            padding: EdgeInsets.symmetric(horizontal: widget.index * 10),
            duration: const Duration(milliseconds: 300),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 2,
                    offset: Offset(2, 2),
                  ),
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 2,
                    offset: Offset(-2, -2),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
