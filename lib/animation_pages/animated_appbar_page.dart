import 'package:flutter/material.dart';

import '../widgets/text_widget.dart';

class AnimatedAppbarPage extends StatefulWidget {
  final Widget? title;
  final double? titleSize;
  final String? titleText;
  final Widget? leading;

  const AnimatedAppbarPage({
    Key? key,
    this.title,
    this.titleSize = 20,
    this.titleText,
    this.leading,
  }) : super(key: key);

  @override
  State<AnimatedAppbarPage> createState() => _AnimatedAppbarPageState();
}

class _AnimatedAppbarPageState extends State<AnimatedAppbarPage> {
  final ScrollController _scrollController = ScrollController();
  final double appBarMiddle = kToolbarHeight / 4;
  late double value;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    value = appBarMiddle;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
          animation: _scrollController,
          builder: (context, child) {
            if (_scrollController.hasClients) {
              if (value < appBarMiddle) {
                value = appBarMiddle;
              } else {
                value = _scrollController.offset * 0.20;
                if ((value + 30) < ((kToolbarHeight * 2) - (kToolbarHeight / 4))) {
                  if (value < appBarMiddle) {
                    value = appBarMiddle;
                  }
                } else {
                  value = ((kToolbarHeight * 2) - (kToolbarHeight / 4)) - 30;
                }
              }
            }
            debugPrint("size of text: ${20 + (value * 0.10)}");
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04),
                child: Stack(
                  children: [
                    Column(children: [
                      Container(
                        height: kToolbarHeight,
                        color: Colors.amberAccent,
                        child: Row(
                          children: [
                            widget.leading ??
                                IconButton(
                                    onPressed: () => Navigator.pop(context),
                                    icon: const Icon(Icons.arrow_back)),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child:
                                    IconButton(onPressed: () => [], icon: const Icon(Icons.search)),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 60),
                      Expanded(
                          child: ListView.builder(
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              controller: _scrollController,
                              itemCount: 100,
                              itemBuilder: (context, index) {
                                return Text("$index");
                              }))
                    ]),
                    Positioned(
                      width: MediaQuery.of(context).size.width * (value * 0.04),
                      top: value,
                      left: MediaQuery.of(context).size.width * 0.20 - value,
                      child: widget.title ??
                          TextWidget(
                            text: widget.titleText ?? "Animated Appbar",
                            overFlow: TextOverflow.ellipsis,
                            maxLines: 1,
                            size: widget.titleSize! + (value * 0.10),
                          ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
