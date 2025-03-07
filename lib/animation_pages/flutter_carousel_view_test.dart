import 'package:flutter/material.dart';

class FlutterCarouselViewTest extends StatefulWidget {
  const FlutterCarouselViewTest({super.key});

  @override
  State<FlutterCarouselViewTest> createState() =>
      _FlutterCarouselViewTestState();
}

class _FlutterCarouselViewTestState extends State<FlutterCarouselViewTest> {
  final List<String> _assets = [];
  late final CarouselController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CarouselController(initialItem: 1);
    _assets.addAll(
      [
        "assets/parallax_effect_images/efe-kurnaz.jpg",
        "assets/parallax_effect_images/flutter.png",
        "assets/parallax_effect_images/rodion-kutsaev.jpeg",
        "assets/parallax_effect_images/steve-johnson.jpeg",
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Carousel view"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: CarouselView.weighted(
                controller: _controller,
                itemSnapping: false,
                flexWeights: const [1, 9, 1],
                // scrollDirection: Axis.vertical,
                children: _assets
                    .map(
                      (element) => Image.asset(
                        element,
                        fit: BoxFit.cover,
                      ),
                    )
                    .toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
