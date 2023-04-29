import 'package:flutter/material.dart';
import 'dart:math' as math;

class PageViewWithController extends StatefulWidget {
  const PageViewWithController({Key? key}) : super(key: key);

  @override
  State<PageViewWithController> createState() => _PageViewWithControllerState();
}

class _PageViewWithControllerState extends State<PageViewWithController> {
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
  }

  int initialPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          height: 200,
          child: PageView.builder(
              controller: controller,
              itemCount: pictureAssets.length,
              onPageChanged: (v) => setState(() {
                    initialPage = v;
                  }),
              itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: rotateImage(index))))
    ]);
  }

  Widget rotateImage(int index) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          double value = 0;
          if (controller.position.haveDimensions) {
            value = index - (controller.page ?? 0);

            //clamp for doing animation to that index for exmaple,
            //you are in 0 index animate with work (-1 left index, zero is your index, 1 right index)
            value = (value * 0.040).clamp(-1, 1);
          }
          return Transform.rotate(
              angle: math.pi * value,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 275),
                opacity: initialPage == index ? 1 : 0.4,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Image.asset(pictureAssets[index],
                      fit: BoxFit.cover),
                ),
              ));
        });
  }
}
