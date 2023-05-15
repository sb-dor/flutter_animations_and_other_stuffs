import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animations_2/nft_pages/nft_screen.dart';

class ImageListView extends StatefulWidget {
  final int startIndex;
  final bool startFromRight;
  final Duration duration;

  const ImageListView(
      {Key? key,
      required this.startIndex,
      required this.startFromRight,
      required this.duration})
      : super(key: key);

  @override
  State<ImageListView> createState() => _ImageListViewState();
}

class _ImageListViewState extends State<ImageListView> {
  late ScrollController scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    scrollController = ScrollController();

    scrollController.addListener(() {
      //detect that it's at the end of listview
      if (scrollController.position.atEdge) {
        _autoScroll();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.startFromRight) {
        //we just check scrolling. from end or not
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
      _autoScroll();
    });
  }

  _autoScroll() {
    //getting current position of scrollcontroller
    final currentScrollPosition = scrollController.offset;

    //getting max position
    final scrollEnd = scrollController.position.maxScrollExtent;

    scheduleMicrotask(() {
      scrollController.animateTo(
          currentScrollPosition == scrollEnd ? 0 : scrollEnd,
          duration: widget.duration,
          curve: Curves.linear);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: pi * 1.97,
      child: SizedBox(
          height: 130,
          child: ListView.builder(
            // physics: const NeverScrollableScrollPhysics(),
              controller: scrollController,
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => _ImageTile(
                  image: "assets/nfts/${widget.startIndex + index}.png"))),
    );
  }
}

class _ImageTile extends StatelessWidget {
  final String image;

  const _ImageTile({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NftScreen(imageAsset: image))),
      child: Hero(
          tag: image,
          child: Image.asset(
            image,
            width: 130,
          )),
    );
  }
}
