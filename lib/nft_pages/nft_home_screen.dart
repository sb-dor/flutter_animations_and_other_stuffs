import 'package:flutter/material.dart';
import 'package:flutter_animations_2/animation_pages/animated_list_with_animations_page.dart';
import 'package:flutter_animations_2/animations/fade_animation.dart';
import 'package:flutter_animations_2/animations/navigation/navigation.dart';
import 'package:flutter_animations_2/animations/navigation/page_transition_animation.dart';
import 'package:flutter_animations_2/nft_pages/widgets/image_list_view.dart';

class NftHomeScreen extends StatelessWidget {
  const NftHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff010101),
      body: Stack(children: [
        Positioned.fill(
            child: ShaderMask(
                blendMode: BlendMode.dstOut,
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black.withOpacity(0.8),
                      Colors.black.withOpacity(0.9),
                      Colors.black
                    ],
                    stops: const [0, 0.62, 0.67, 0.85, 1],
                  ).createShader(bounds);
                },
                child: const FadeAnimation(
                    intervalStart: 0.1,
                    child: SingleChildScrollView(
                        child: Column(children: [
                      SizedBox(height: 30),
                      ImageListView(
                          startIndex: 1,
                          startFromRight: false,
                          duration: Duration(seconds: 25)),
                      ImageListView(
                          startIndex: 11,
                          startFromRight: true,
                          duration: Duration(seconds: 35)),
                      ImageListView(
                          startIndex: 21,
                          startFromRight: false,
                          duration: Duration(seconds: 45)),
                      ImageListView(
                          startIndex: 31,
                          startFromRight: true,
                          duration: Duration(seconds: 25))
                    ]))))),
        Positioned(
            bottom: 60,
            left: 24,
            right: 24,
            child: SizedBox(
                height: 170,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const FadeAnimation(
                          intervalStart: 0.2,
                          child: Text("Art with NFTs",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white))),
                      const SizedBox(height: 20),
                      const FadeAnimation(
                          intervalStart: 0.3,
                          child: Text(
                              "Check out everything from this app and know moew about NFTs",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white54))),
                      const Spacer(),
                      FadeAnimation(
                          intervalStart: 0.4,
                          child: InkWell(
                            onTap: () => Navigation.push(context,
                                customPageTransition: PageTransition(
                                    child:
                                        const AnimatedListWithAnimationPage(),
                                    type: PageTransitionType
                                        .scaleDownWithFadeIn)),
                            child: Container(
                                width: 140,
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: const Color(0xff3000ff)),
                                child: const Text("Discover",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))),
                          ))
                    ])))
      ]),
    );
  }
}
