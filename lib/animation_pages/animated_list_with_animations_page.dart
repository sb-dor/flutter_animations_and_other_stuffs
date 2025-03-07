import 'package:flutter/material.dart';
import 'package:flutter_animations_2/animation_pages/neumorphic_page_transitions_container_page.dart';
import 'package:flutter_animations_2/animations/fade_animation.dart';
import 'package:flutter_animations_2/animations/scale_animation.dart';
import 'package:flutter_animations_2/animations/slide_animation.dart';

class AnimatedListWithAnimationPage extends StatelessWidget {
  const AnimatedListWithAnimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const NeumorphicContainer())),
              icon: const Icon(Icons.add))
        ],
      ),
      body: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 20),
          itemCount: 10,
          itemBuilder: (context, index) => SlideAnimation(
                intervalStart: getIntervalStartByIndex(index),
                duration: const Duration(milliseconds: 1500),
                curve: Curves.bounceOut,
                begin: const Offset(150, 0),
                child: Card(
                    color: Colors.amber,
                    child: Row(children: [
                      ScaleAnimation(
                        begin: 0.4,
                        end: 1,
                        curve: Curves.elasticInOut,
                        duration: const Duration(milliseconds: 1500),
                        intervalStart: getIntervalStartByIndex(index + 3),
                        child: SlideAnimation(
                          begin: const Offset(0, 150),
                          // end: Offset(0,100),
                          duration: const Duration(milliseconds: 500),
                          intervalStart: getIntervalStartByIndex(index + 5),
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.asset('assets/nfts/${index + 1}.png'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        FadeAnimation(
                          intervalStart: getIntervalStartByIndex(index),
                          child: const Text("Gladias Baker",
                              style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                        const SizedBox(height: 10),
                        SlideAnimation(
                          intervalStart: getIntervalStartByIndex(index),
                          child: const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Icon(Icons.star, color: Colors.amber, size: 20),
                            Flexible(
                              child: Text("4.3 ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                            ),
                            Text("Digital Art ", style: TextStyle(color: Colors.black45)),
                            Flexible(
                              child: Text("\$2.2", style: TextStyle(color: Colors.black45)),
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
