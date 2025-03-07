import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animations_2/widgets/text_widget.dart';

class DodoPizzaTurnPizzaAnimation extends StatefulWidget {
  const DodoPizzaTurnPizzaAnimation({super.key});

  @override
  State<DodoPizzaTurnPizzaAnimation> createState() =>
      _DodoPizzaTurnPizzaAnimationState();
}

class _DodoPizzaTurnPizzaAnimationState
    extends State<DodoPizzaTurnPizzaAnimation> {
  late final PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dodo pizza animation"),
      ),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.720,
          width: MediaQuery.of(context).size.width,
          // color: Colors.red,
          child: PageView(
            // pageSnapping: false,
            controller: _pageController,
            // padEnds: false,
            children: const [
              MainTurnAnimation(),
              MainTurnAnimation(),
              MainTurnAnimation(),
            ],
          ),
        ),
      ),
    );
  }
}

class MainTurnAnimation extends StatefulWidget {
  const MainTurnAnimation({super.key});

  @override
  State<MainTurnAnimation> createState() => _MainTurnAnimationState();
}

class _MainTurnAnimationState extends State<MainTurnAnimation>
    with TickerProviderStateMixin {
  late AnimationController _firstWidgetTurnAnimationController;
  late AnimationController _secondWidgetTurnAnimationController;
  late Animation<double> _firstWidgetTurnAnimation;
  late Animation<double> _secondWidgetTurnAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firstWidgetTurnAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _secondWidgetTurnAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _firstWidgetTurnAnimation = Tween<double>(begin: 0, end: pi)
        .animate(_firstWidgetTurnAnimationController);
    _secondWidgetTurnAnimation = Tween<double>(begin: -pi, end: 0)
        .animate(_secondWidgetTurnAnimationController);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _firstWidgetTurnAnimationController,
        builder: (context, child1) {
          return AnimatedBuilder(
              animation: _secondWidgetTurnAnimationController,
              builder: (context, child2) {
                bool showFirstWidget = true;
                bool showSecondWidget = false;
                if (_firstWidgetTurnAnimation.value.abs() < pi / 2) {
                  showFirstWidget = true;
                  showSecondWidget = false;
                } else {
                  showSecondWidget = true;
                  showFirstWidget = false;
                }
                return Stack(
                  children: [
                    if (showFirstWidget)
                      Positioned.fill(
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..rotateY(_firstWidgetTurnAnimation.value),
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                // border: Border.all(color: Colors.grey),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    offset: const Offset(0.5, 0.5),
                                    blurRadius: 5,
                                  )
                                ]),
                            child: Column(
                              children: [
                                Image.asset(
                                    'assets/dodo_pizza_often_order_pictures/dodo_0.jpeg'),
                                ElevatedButton(
                                    onPressed: () {
                                      if (_firstWidgetTurnAnimationController
                                              .isCompleted &&
                                          _secondWidgetTurnAnimationController
                                              .isCompleted) {
                                        _firstWidgetTurnAnimationController
                                            .reverse();
                                        _secondWidgetTurnAnimationController
                                            .reverse();
                                        return;
                                      }
                                      _firstWidgetTurnAnimationController
                                          .forward();
                                      _secondWidgetTurnAnimationController
                                          .forward();
                                    },
                                    child: const TextWidget(
                                        text: "Change compatibles"))
                              ],
                            ),
                          ),
                        ),
                      ),
                    if (showSecondWidget)
                      Positioned.fill(
                        // bottom: 10,
                        // right: 10,
                        // left: 10,
                        // top: 10,
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..rotateY(_secondWidgetTurnAnimation.value),
                          child: GestureDetector(
                            onTap: () {
                              if (_firstWidgetTurnAnimationController
                                      .isCompleted &&
                                  _secondWidgetTurnAnimationController
                                      .isCompleted) {
                                _firstWidgetTurnAnimationController.reverse();
                                _secondWidgetTurnAnimationController.reverse();
                                return;
                              }
                              _firstWidgetTurnAnimationController.forward();
                              _secondWidgetTurnAnimationController.forward();
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                  color: Colors.orange.shade200,
                                  borderRadius: BorderRadius.circular(30),
                                  // border: Border.all(color: Colors.grey),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade400,
                                      offset: const Offset(0.5, 0.5),
                                      blurRadius: 5,
                                    )
                                  ]),
                              child: Column(
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        if (_firstWidgetTurnAnimationController
                                                .isCompleted &&
                                            _secondWidgetTurnAnimationController
                                                .isCompleted) {
                                          _firstWidgetTurnAnimationController
                                              .reverse();
                                          _secondWidgetTurnAnimationController
                                              .reverse();
                                          return;
                                        }
                                        _firstWidgetTurnAnimationController
                                            .forward();
                                        _secondWidgetTurnAnimationController
                                            .forward();
                                      },
                                      child: const TextWidget(text: "Отмена"))
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                  ],
                );
              });
        });
  }
}
