import 'package:flutter/material.dart';
import 'package:flutter_animations_2/animations/blur_container.dart';
import 'package:flutter_animations_2/animations/fade_animation.dart';

class NftScreen extends StatelessWidget {
  final String imageAsset;

  const NftScreen({Key? key, required this.imageAsset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(children: [
            Hero(tag: imageAsset, child: Image.asset(imageAsset)),
            Positioned(
                bottom: 10,
                // right: 0,
                left: 15,
                child: FadeAnimation(
                  intervalEnd: 0.3,
                  child: BlurContainer(
                      child: Container(
                    width: 160,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white54.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(8)),
                    child: const Center(
                        child: Text(
                      "Digital nft art",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                  )),
                ))
          ]),
          const SizedBox(height: 15),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeAnimation(
                      intervalStart: 0.2,
                      child: Text("Monkey #10",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                    ),
                    SizedBox(height: 15),
                    FadeAnimation(
                      intervalStart: 0.3,
                      child: Text("Own by Gennady",
                          style: TextStyle(
                            color: Colors.white54,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          )),
                    ),
                    SizedBox(height: 40),
                    FadeAnimation(
                      intervalStart: 0.4,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InfoTile(
                                title: "3d 5h 10m", content: "Remaining Time"),
                            InfoTile(
                                title: "3d 5h 10m", content: "Remaining Time"),
                          ]),
                    ),
                    Spacer(),
                    FadeAnimation(
                      intervalStart: 0.5,
                      child: Container(
                        width: double.maxFinite,
                        height: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color(0xff3000ff),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text("Place bid",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),

                      ),
                    ),
                    SizedBox(height: 40)
                  ]),
            ),
          )
        ]));
  }
}

class InfoTile extends StatelessWidget {
  final String title;
  final String content;

  const InfoTile({Key? key, required this.title, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(title,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
      SizedBox(height: 10),
      Text(title, style: TextStyle(color: Colors.white54))
    ]);
  }
}
