import 'package:flutter/material.dart';
import 'dart:math' as math;

class CardModel {
  final String name, image, date;

  CardModel({required this.name, required this.image, required this.date});
}

List<CardModel> demoCardData = [
  CardModel(
    name: "Shenzhen GLOBAL DESIGN AWARD 2018",
    image: "steve-johnson.jpeg",
    date: "4.20-30",
  ),
  CardModel(
    name: "Dawan District, Guangdong Hong Kong and Macao",
    image: "rodion-kutsaev.jpeg",
    date: "4.28-31",
  ),
  CardModel(
    name: "Efe-kurnaz",
    image: "flutter.png",
    date: "4.28-31",
  ),
];

class FlutterParallaxHorizontalEffect extends StatefulWidget {
  const FlutterParallaxHorizontalEffect({Key? key}) : super(key: key);

  @override
  State<FlutterParallaxHorizontalEffect> createState() => _FlutterParallaxEffectState();
}

class _FlutterParallaxEffectState extends State<FlutterParallaxHorizontalEffect> {
  late PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(viewportFraction: 0.8, initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.70,
          child: PageView.builder(
            clipBehavior: Clip.none,
            controller: _pageController,
            itemCount: demoCardData.length,
            itemBuilder: (context, index) {
              // double offset = pageOffset - index;

              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  //remember that for a good animation your picture should not be as phone size
                  //rather laptop size

                  //this pageOffset will animate parallax effect
                  double pageOffset = 0;
                  if (_pageController.position.haveDimensions) {
                    // pageOffset = _pageController.page!;
                    //if you want to animate from another side just minus the _pageController.page with index:
                    //remember to use code down below if you want that transform.translate work
                    pageOffset = _pageController.page! - index;
                  }

                  //for more animation use:
                  double gauss = math.exp(-(math.pow((pageOffset.abs() - 0.5), 2) / 0.08));

                  //also you can remove transform.translate if you want
                  return Transform.translate(
                    offset: Offset(-32 * gauss * pageOffset.sign, 0),
                    child: Container(
                      clipBehavior: Clip.none,
                      margin: const EdgeInsets.only(left: 8, right: 8, bottom: 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(8, 20),
                            blurRadius: 24,
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Align(alignment: Alignment(pageOffset, 0), child: Text("Avaz")),
                          // Image
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                            //remember that for a good animation your picture should not be as phone size
                            //rather laptop size
                            //we just want to animate image
                            child: Image.asset(
                              'assets/parallax_effect_images/${demoCardData[index].image}',
                              height: MediaQuery.of(context).size.height * 0.3,
                              fit: BoxFit.none,
                              //add alignment to this image parameter
                              alignment: Alignment(pageOffset, 0),
                            ),
                          ),
                          // Rest of the content
                          const SizedBox(height: 8),
                          Expanded(
                            child: CardContent(
                              name: demoCardData[index].name,
                              date: demoCardData[index].date,
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
    );
  }
}

class CardContent extends StatelessWidget {
  final String name;
  final String date;

  const CardContent({
    super.key,
    required this.name,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(name, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 8),
          Text(
            date,
            style: const TextStyle(color: Colors.grey),
          ),
          const Spacer(),
          Row(
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF162A49),
                  textStyle: const TextStyle(color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                onPressed: () {},
                child: const Text('Reserve'),
              ),
              const Spacer(),
              const Text(
                '0.00 \$',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(width: 16),
            ],
          )
        ],
      ),
    );
  }
}
