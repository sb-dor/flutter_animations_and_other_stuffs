import 'package:flutter/material.dart';
import 'package:flutter_animations_2/animation_pages/flutter_parallax_horizontal_effect.dart';
import 'package:hexcolor/hexcolor.dart';

class StackScrollAnimationPage extends StatefulWidget {
  const StackScrollAnimationPage({super.key});

  @override
  State<StackScrollAnimationPage> createState() => _StackScrollAnimationPageState();
}

class _StackScrollAnimationPageState extends State<StackScrollAnimationPage> {
  late final PageController _pageController;

  final double leftSidePercentage = 25.0;

  final double eachCardHeight = 250;

  List<CardModel> demoCardData = [
    CardModel(
      name: "Shenzhen GLOBAL DESIGN AWARD 2018",
      image: "steve-johnson.jpeg",
      date: "4.20-30",
      position: 0.0,
    ),
    CardModel(
      name: "Dawan District, Guangdong Hong Kong and Macao",
      image: "efe-kurnaz.jpg",
      date: "4.28-31",
      position: 0.0,
    ),
    CardModel(
      name: "Efe-kurnaz",
      image: "flutter.png",
      date: "4.28-31",
      position: 0.0,
    ),
    CardModel(
      name: "Efe-kurnaz",
      image: "rodion-kutsaev.jpeg",
      date: "4.28-31",
      position: 0.0,
    ),
    CardModel(
      name: "Dawan District, Guangdong Hong Kong and Macao",
      image: "efe-kurnaz.jpg",
      date: "4.28-31",
      position: 0.0,
    ),
  ];

  double _findPosByIndex(int index) {
    double value = eachCardHeight - (eachCardHeight * ((index + 1) / 10));
    double minus = eachCardHeight - value;
    double result = eachCardHeight + (minus * (_pageController.page! - index));
    return result;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pageController = PageController(viewportFraction: 0.9);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      demoCardData
          .asMap()
          .entries
          .map(
            (e) => e.value
              ..position = -(e.key + 1) * leftSidePercentage
              ..height = eachCardHeight - (eachCardHeight * ((e.key + 1) / 10)),
          )
          .toList(); // to set beautiful position for each item in list
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.black,
                  HexColor("#1e1f1a"),
                ],
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: kToolbarHeight,
                ),
                const Expanded(
                  child: Text(
                    "Explore",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                )
              ],
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.black,
                HexColor("#1e1f1a"),
              ],
            ),
          ),
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    return SizedBox(
                      height: 300,
                      child: Center(
                        child: Stack(
                          children: [
                            Stack(
                                clipBehavior: Clip.none,
                                children: demoCardData
                                    .asMap()
                                    .entries
                                    .map(
                                      (e) => Positioned(
                                        left: -(e.value.position),
                                        bottom: 0,
                                        top: 0,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 200,
                                              height: e.value.height,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: Image.asset(
                                                  "assets/parallax_effect_images/${e.value.image}",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList()
                                    .reversed
                                    .toList()),

                            // in order to animate stack we use pageview
                            // as helper to animate stack
                            // pageview itselft doesn't have anything inside
                            PageView.builder(
                              allowImplicitScrolling: false,
                              padEnds: false,
                              controller: _pageController,
                              itemCount: demoCardData.length,
                              itemBuilder: (context, index) {
                                debugPrint("index: $index | page: ${_pageController.page}");

                                // animation should work only on specific card item in stack
                                // while we scroll item that time animation will work
                                if (_pageController.position.hasContentDimensions &&
                                    (_pageController.page ?? 0) > index &&
                                    (_pageController.page ?? 0) < index + 1) {
                                  // position from left side of the screen
                                  double positionFromLeftSide = -(index + 1) * leftSidePercentage;

                                  //
                                  demoCardData[index].position =
                                      ((index - (_pageController.page ?? 0)).abs() * 400) +
                                          positionFromLeftSide;

                                  //
                                } else if ((_pageController.page ?? 0) < index &&
                                    _pageController.position.hasContentDimensions) {
                                  demoCardData[index].position = -(index + 1) *
                                      leftSidePercentage; // after ending animation set their default position

                                  //
                                }

                                if (_pageController.position.hasContentDimensions) {
                                  if (index > _pageController.page!) {
                                    demoCardData[index].height = _findPosByIndex(index);
                                  } else {}
                                }

                                //

                                return const SizedBox();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Favorite",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.more_horiz,
                      size: 30,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ListView.separated(
                padding: const EdgeInsets.only(left: 20, right: 20),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => const SizedBox(height: 10),
                itemCount: demoCardData.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        "assets/parallax_effect_images/${demoCardData[index].image}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
