import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations_2/animation_pages/youtube_flutter_location_animation/models/yt_fl_loc_model.dart';

class YoutubeCoffeeAppAnimationPage extends StatefulWidget {
  const YoutubeCoffeeAppAnimationPage({super.key});

  @override
  State<YoutubeCoffeeAppAnimationPage> createState() => _YoutubeCoffeeAppAnimationPageState();
}

class _YoutubeCoffeeAppAnimationPageState extends State<YoutubeCoffeeAppAnimationPage> {
  late PageController _pageController;
  List<YtFlLocModel> list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.350);
    for (int i = 1; i <= 12; i++) {
      list.add(YtFlLocModel(
          imageUrl: 'assets/youtube_coffee_anim_pic/$i.png',
          address: Faker().address.streetName(),
          location: Faker().address.country()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Coffee app animtaion"),
      // ),
      body: AnimatedBuilder(
        animation: _pageController,
        builder: (context, chile) {
          return PageView.builder(
            controller: _pageController,
            padEnds: false,
            scrollDirection: Axis.vertical,
            itemCount: list.length,
            itemBuilder: (context, index) {
              double valueOfAnim = 0.0;
              double translateValue = 0.0;
              if (_pageController.position.haveDimensions) {
                final double position = index - (_pageController.page ?? 0);
                valueOfAnim = (position * 0.4).clamp(0, 1);
                if ((_pageController.page ?? 0).toInt() <= index) {
                  translateValue = position * 30;
                }
                debugPrint("index: $index | translate: $translateValue");
                debugPrint("page: ${_pageController.page?.toInt()}");
              }
              return Center(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  height: 100,
                  width: 100,
                  child: Image.asset(
                    list[index].imageUrl ?? '-',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
