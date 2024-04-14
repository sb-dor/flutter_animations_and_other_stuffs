import 'package:faker/faker.dart' as f;
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animations_2/animation_pages/flutter_tutorial_diegoveloper_list_animation/models/flutter_diegodev_animation_list_model.dart';
import 'package:flutter_animations_2/functions/global_functions.dart';
import 'package:flutter_animations_2/functions/randoms.dart';

class FlutterTutorialDiegoDeveloperListAnimation extends StatefulWidget {
  const FlutterTutorialDiegoDeveloperListAnimation({super.key});

  @override
  State<FlutterTutorialDiegoDeveloperListAnimation> createState() =>
      _FlutterTutorialDeListaAnimadaState();
}

class _FlutterTutorialDeListaAnimadaState
    extends State<FlutterTutorialDiegoDeveloperListAnimation> {
  List<FlutterDiegoDevAnimListModel> items = [];

  final ScrollController _scrollController = ScrollController();

  double eachIndexPosition = 0;

  double eachItemSize = 150; // item's size in list

  double startAnimationOffset = 50;

  bool isTopListClosed = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items = List.generate(
      10,
      (index) => FlutterDiegoDevAnimListModel(
        color: f.Faker().color.color().toColor,
        price: f.Faker().food.random.decimal(),
        image: Randoms.randomPictureUrl(),
      ),
    );

    _scrollController.addListener(_scrollListener);
  }

  // listening the scroll here
  void _scrollListener() {
    if (_scrollController.offset >= startAnimationOffset) {
      eachIndexPosition = (_scrollController.offset - startAnimationOffset) /
          (eachItemSize * 0.650); // alignment's heightFactor (take a loog the code below)
    }

    isTopListClosed = _scrollController.offset > 50;

    setState(() {});

    // debugPrint('offet: ${_scrollController.offset}');

    // debugPrint("item position: $eachIndexPosition");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List animation"),
      ),
      body: ListView(
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        controller: _scrollController,
        shrinkWrap: true,
        children: [
          AnimatedOpacity(
            opacity: isTopListClosed ? 0 : 1,
            duration: const Duration(milliseconds: 200),
            child: AnimatedContainer(
              alignment: Alignment.bottomCenter,
              duration: const Duration(milliseconds: 200),
              height: isTopListClosed ? 0 : 200,
              child: ListView.separated(
                padding: const EdgeInsets.only(left: 10, right: 10),
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(item.image),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 50),
          AnimatedBuilder(
              animation: _scrollController,
              builder: (context, child) {
                return ListView.builder(
                  padding: EdgeInsets.only(top: 50),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];

                    double scale = 1.0;

                    // if top list is closed than works is statement
                    if (isTopListClosed) {
                      // eachIndexPosition is the scrolling position on the list
                      if (index <= (eachIndexPosition.toInt())) {
                        scale = 1 - (index - eachIndexPosition).abs();
                      } else {
                        scale = 1;
                      }

                      if (scale < 0) scale = 0;
                    }

                    return Opacity(
                      opacity: scale,
                      child: Transform.scale(
                        alignment: Alignment.center,
                        scale: scale,
                        child: Align(
                          heightFactor:
                              0.650, // takes the whole size of the item and multiplies it by 0.650
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: eachItemSize,
                            width: MediaQuery.of(context).size.width,
                            padding:
                                const EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 15),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                item.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              })
        ],
      ),
    );
  }
}
