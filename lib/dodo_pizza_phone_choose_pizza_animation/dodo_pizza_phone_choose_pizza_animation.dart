import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations_2/dodo_pizza_phone_choose_pizza_animation/model/dodo_pizza_model.dart';

class HalfOfRightContainer extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.moveTo(0, 0);

    path.lineTo(0, size.height);

    path.lineTo(size.width / 2, size.height);

    path.lineTo(size.width / 2, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class HalfOfLeftContainer extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    debugPrint("length: ${size.width} | ${size.width / 2}");

    path.moveTo(size.width, 0);

    path.lineTo(size.width, size.height);

    path.lineTo(size.width / 2, size.height);

    path.lineTo(size.width / 2, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class DodoPizzaPhoneChoosePizzaAnimation extends StatefulWidget {
  const DodoPizzaPhoneChoosePizzaAnimation({super.key});

  @override
  State<DodoPizzaPhoneChoosePizzaAnimation> createState() =>
      _DodoPizzaPhoneChoosePizzaAnimationState();
}

class _DodoPizzaPhoneChoosePizzaAnimationState extends State<DodoPizzaPhoneChoosePizzaAnimation>
    with TickerProviderStateMixin {
  late PageController firstPageController;
  late PageController secondPageController;
  double initialPageOfFirstController = 0.0;
  double initialPageOfSecondController = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstPageController = PageController(initialPage: 0, viewportFraction: 0.550);
    secondPageController = PageController(initialPage: 0, viewportFraction: 0.550);

    firstPageController.addListener(() {
      setState(() {
        initialPageOfFirstController = firstPageController.page ?? 0.0;
      });
    });

    secondPageController.addListener(() {
      setState(() {
        initialPageOfSecondController = secondPageController.page ?? 0.0;
      });
    });
  }

  void randomPizzaChoice() {
    var rnd = Random();

    var firstRandom = rnd.nextInt(DodoPizzaModel.list.length);
    var secondRandom = rnd.nextInt(DodoPizzaModel.list.length);

    if (firstRandom == secondRandom) {
      randomPizzaChoice();
      return;
    }

    firstPageController.animateToPage(firstRandom,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
    secondPageController.animateToPage(secondRandom,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => [], icon: const Icon(Icons.arrow_back_ios)),
        title: const Text('Пиццы из половинок'),
        backgroundColor: Colors.white,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: PageView.builder(
                            padEnds: true,
                            scrollDirection: Axis.vertical,
                            controller: firstPageController,
                            itemCount: DodoPizzaModel.list.length,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              //for smoothly changing, the widget where is in index position will
                              // be typically but other widgets will smoothly change their scale
                              double scale =
                                  (1 - (initialPageOfFirstController - index).abs() * 0.50)
                                      .clamp(0.65, 1.0);

                              return Padding(
                                padding: EdgeInsets.only(
                                    left: (MediaQuery.of(context).size.width / 2) / 2.61),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      height: 250,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 0,
                                            top: 0,
                                            bottom: 0,
                                            child: Transform.scale(
                                              scale: scale,
                                              child: ClipPath(
                                                clipper: HalfOfRightContainer(),
                                                child: SizedBox(
                                                  width: MediaQuery.of(context).size.width / 1.61,
                                                  child: Image.asset(
                                                      "${DodoPizzaModel.list[index].image}",
                                                      fit: BoxFit.contain),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            })),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: PageView.builder(
                            padEnds: true,
                            scrollDirection: Axis.vertical,
                            controller: secondPageController,
                            itemCount: DodoPizzaModel.list.length,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              //for smoothly changing, the widget where is in index position will
                              // be typically but other widgets will smoothly change their scale
                              double scale =
                                  (1 - (initialPageOfSecondController - index).abs() * 0.50)
                                      .clamp(0.65, 1.0);
                              return Padding(
                                padding: EdgeInsets.only(
                                    right: (MediaQuery.of(context).size.width / 2) / 2.61),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 250,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            right: 0,
                                            top: 0,
                                            bottom: 0,
                                            child: Transform.scale(
                                              scale: scale,
                                              child: ClipPath(
                                                clipper: HalfOfLeftContainer(),
                                                child: SizedBox(
                                                  width: MediaQuery.of(context).size.width / 1.61,
                                                  child: Image.asset(
                                                      "${DodoPizzaModel.list[index].image}",
                                                      fit: BoxFit.contain),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            })),
                  ),
                  Positioned(
                      bottom: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () => randomPizzaChoice(),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(1, 1),
                                    color: Colors.grey.shade400,
                                    blurRadius: 5)
                              ]),
                          child: const RotationTransition(
                              turns: AlwaysStoppedAnimation(20 / 360),
                              child: Icon(CupertinoIcons.cube_fill)),
                        ),
                      ))
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 70,
              margin: const EdgeInsets.only(left: 15, right: 15),
              decoration:
                  BoxDecoration(color: Colors.deepOrange, borderRadius: BorderRadius.circular(50)),
              child: const Center(
                  child: Text(
                "Объеденить половинок",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2),
              )),
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
