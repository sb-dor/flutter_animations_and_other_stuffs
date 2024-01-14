import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations_2/animation_pages/youtube_flutter_location_animation/models/yt_fl_loc_model.dart';
import 'package:flutter_animations_2/functions/randoms.dart';

class YoutubeFlutterAnimationPage extends StatefulWidget {
  const YoutubeFlutterAnimationPage({super.key});

  @override
  State<YoutubeFlutterAnimationPage> createState() => _YoutubeFlutterAnimationPageState();
}

class _YoutubeFlutterAnimationPageState extends State<YoutubeFlutterAnimationPage> {
  late PageController _pageController;
  List<YtFlLocModel> list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(viewportFraction: 0.8, initialPage: 0);

    for (int i = 0; i < 10; i++) {
      list.add(YtFlLocModel(
          imageUrl: Randoms.randomPictureUrl(),
          address: Faker().address.streetName(),
          location: Faker().address.country()));
    }
  }

  void clickedShow(YtFlLocModel model) {
    model.isOpen = !model.isOpen;
    list[list.indexWhere((e) => e.imageUrl == model.imageUrl)] = model;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter youtube location animation"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: AnimatedBuilder(
              animation: _pageController,
              builder: (context, child) {
                return PageView.builder(
                  controller: _pageController,
                  itemCount: list.length,
                  padEnds: true,
                  itemBuilder: (context, index) {
                    double value = 0.0;
                    if (_pageController.position.haveDimensions) {
                      value = index - (_pageController.page ?? 0);

                      value = (value * 0.070).clamp(0.0, 1.0);
                    }

                    return Transform.scale(
                      scale: value + 1,
                      child: GestureDetector(
                        onTap: () => clickedShow(list[index]),
                        onDoubleTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => _PageForAddressView(
                              ytFlLocModel: list[index],
                            ),
                          ),
                        ),
                        child: Stack(
                          children: [
                            AnimatedPositioned(
                              duration: const Duration(milliseconds: 250),
                              top: 0,
                              right: list[index].isOpen ? 5 : 15,
                              left: list[index].isOpen ? 5 : 15,
                              bottom: list[index].isOpen ? -70 : 0,
                              child: Center(
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  height: 300,
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: list[index].isOpen
                                          ? [const BoxShadow(color: Colors.grey, blurRadius: 5)]
                                          : []),
                                  child: Hero(
                                    tag: "${list[index].imageUrl ?? '-'}_about",
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text("${list[index].address}"),
                                          Text("${list[index].location}"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            AnimatedPositioned(
                              duration: const Duration(milliseconds: 250),
                              top: 0,
                              right: 15,
                              left: 15,
                              bottom: list[index].isOpen ? 70 : 0,
                              child: _CardItem(
                                ytFlLocModel: list[index],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _CardItem extends StatelessWidget {
  final YtFlLocModel ytFlLocModel;

  const _CardItem({super.key, required this.ytFlLocModel});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: ytFlLocModel.imageUrl ?? '-',
        child: SizedBox(
          height: 300,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              ytFlLocModel.imageUrl ?? '',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class _PageForAddressView extends StatelessWidget {
  final YtFlLocModel ytFlLocModel;

  const _PageForAddressView({
    super.key,
    required this.ytFlLocModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Hero(
            tag: ytFlLocModel.imageUrl ?? '-',
            child: SizedBox(
              height: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  ytFlLocModel.imageUrl ?? '',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Hero(
            tag: "${ytFlLocModel.imageUrl ?? '-'}_about",
            child: Material(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${ytFlLocModel.address}"),
                  Text("${ytFlLocModel.location}"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
