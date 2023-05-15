import 'package:flutter/material.dart';
import 'package:flutter_animations_2/animations/fade_animation.dart';
import 'package:flutter_animations_2/animations/scale_animation.dart';
import 'package:flutter_animations_2/animations/slide_animation.dart';

class AnimatedListWithAnimationPage extends StatelessWidget {
  const AnimatedListWithAnimationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 20),
          itemCount: 10,
          itemBuilder: (context, index) => SizedBox(
                width: 100,
                height: 100,
                child: Card(
                    child: Row(children: [
                  ScaleAnimation(
                    begin: 0.3,
                    end:1,
                    duration: const Duration(milliseconds: 1000),
                    intervalStart: getIntervalStartByIndex(index),
                    child: SlideAnimation(
                      begin: const Offset(0, 50),
                      // end: Offset(0,100),
                      duration: const Duration(milliseconds: 1000),
                      intervalStart: getIntervalStartByIndex(index + 1),
                      child: Container(
                        width: 100,
                        height: 100,
                        child: Image.asset('assets/nfts/${index + 1}.png'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        FadeAnimation(
                          intervalStart: getIntervalStartByIndex(index),
                          child: const Text("Gladias Baker",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                        ),
                        const SizedBox(height: 10),
                        SlideAnimation(
                          intervalStart: getIntervalStartByIndex(index),
                          child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 20),
                                Flexible(
                                  child: Text("4.3 ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                ),
                                Text("Digital Art ",
                                    style: TextStyle(color: Colors.black45)),
                                Flexible(
                                  child: Text("\$2.2",
                                      style: TextStyle(color: Colors.black45)),
                                ),
                              ]),
                        )
                      ]))
                ])),
              )),
    );
  }

  double getIntervalStartByIndex(int index) {
    return double.parse('0.${index + 1}');
  }
}
