import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_animations_2/models/product.dart';

class PageViewWithController extends StatefulWidget {
  const PageViewWithController({super.key});

  @override
  State<PageViewWithController> createState() => _PageViewWithControllerState();
}

class _PageViewWithControllerState extends State<PageViewWithController> {
  late Timer timer;

  List<String> pictureAssets = [
    'assets/images/ice_cream.jpg',
    'assets/images/mister_bean.jpg',
    'assets/images/nuka_cola.jpg'
  ];

  late PageController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller =
        PageController(initialPage: 0, viewportFraction: 0.5, keepPage: true);

    Product newP = Product(id: 1, price: 15, name: "Apple", pack_qty: 15);

    newP.qty = 1.2;

    debugPrint("get qty: ${newP.getFromDouble()}");
    controller.addListener(() {
      setState(() {
        initialPage = controller.page?.round() ?? 0;
      });
    });
    startTimer();
  }

  int initialPage = 0;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      if (initialPage < pictureAssets.length) {
        // Assuming there are 3 pages, change to the next page.
        initialPage++;
      } else {
        // If we reach the last page, go back to the first page.
        initialPage = 0;
        controller.jumpToPage(initialPage);
        return;
      }
      controller.animateToPage(initialPage,
          duration: const Duration(seconds: 1), curve: Curves.linear);
    });
  }

  void stopTimer() {
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Listener(
        onPointerDown: (down) {
          stopTimer();
        },
        onPointerUp: (up) {
          startTimer();
        },
        child: GestureDetector(
          onHorizontalDragUpdate: (move) {
            //if you are using on popup or physics that disables scrolling
            //this is for moving page view with gesture detector
            controller.jumpTo(controller.offset - move.delta.dx);
          },
          child: SizedBox(
              height: 200,
              child: PageView.builder(
                  controller: controller,
                  // padEnds: false,

                  // pageSnapping: false, // if pageSnapping will be false you will scroll page like listview

                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: pictureAssets.length,
                  onPageChanged: (v) => setState(() {
                        initialPage = v;
                      }),
                  itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: rotateImage(index)))),
        ),
      )
    ]);
  }

  Widget rotateImage(int index) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          //for smoothly changing, the widget where is in index position will be typically but other widgets will smoothly change their scale
          //double scale =
          //(1 - (initialPageOfFirstController - index).abs() * 0.50)
          // .clamp(0.65, 1.0);

          double value = 0;
          double scale = initialPage == index ? 1 : 0.8;
          if (controller.position.haveDimensions) {
            value = index - (controller.page ?? 0);

            //clamp for doing animation to that index for example,
            //you are in 0 index animate with work (-1 left index, zero is your index, 1 right index)
            value = (value * 0.040).clamp(-1, 1);
          }
          return Transform.rotate(
              //for rotating transform.rotate
              angle: math.pi * value,
              child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: scale, end: scale),
                  duration: const Duration(milliseconds: 75),
                  child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 275),
                      opacity: initialPage == index ? 1 : 0.4,
                      child:
                          Image.asset(pictureAssets[index], fit: BoxFit.cover)),
                  builder: (BuildContext context, value, Widget? child) {
                    return Transform.scale(scale: value, child: child);
                  }));
        });
  }
}
