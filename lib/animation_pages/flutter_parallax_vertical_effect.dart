import 'package:flutter/material.dart';
import 'package:flutter_animations_2/animation_pages/flutter_parallax_horizontal_effect.dart';

class FlutterParallaxVerticalEffect extends StatefulWidget {
  const FlutterParallaxVerticalEffect({super.key});

  @override
  State<FlutterParallaxVerticalEffect> createState() => _FlutterParallaxVerticalEffectState();
}

class _FlutterParallaxVerticalEffectState extends State<FlutterParallaxVerticalEffect> {
  List<CardModel> demoCardData = [
    CardModel(
      name: "Shenzhen GLOBAL DESIGN AWARD 2018",
      image: "steve-johnson.jpeg",
      date: "4.20-30",
    ),
    CardModel(
      name: "Dawan District, Guangdong Hong Kong and Macao",
      image: "efe-kurnaz.jpg",
      date: "4.28-31",
    ),
    CardModel(
      name: "Efe-kurnaz",
      image: "flutter.png",
      date: "4.28-31",
    ),
  ];

  late PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(viewportFraction: 0.8, initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      height: MediaQuery.of(context).size.height,
      child: PageView.builder(
          scrollDirection: Axis.vertical,
          controller: _pageController,
          itemCount: demoCardData.length, // getting from flutter_parallax_horizontal_page
          itemBuilder: (context, index) {
            return AnimatedBuilder(
              animation: _pageController,
              builder: (context, child) {
                double pageOffset = 0;
                if (_pageController.position.haveDimensions) {
                  pageOffset = _pageController.page! - index;
                }
                return Container(
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5), offset: const Offset(1, 1), blurRadius: 5)
                  ]),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                            "assets/parallax_effect_images/${demoCardData[index].image}",
                            fit: BoxFit.none,
                            alignment: Alignment(0, pageOffset)),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
    ));
  }
}
