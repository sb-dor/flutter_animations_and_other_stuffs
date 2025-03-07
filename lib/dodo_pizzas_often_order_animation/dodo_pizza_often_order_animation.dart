import 'package:flutter/material.dart';

class DodoPizzaOftenOrderAnimation extends StatefulWidget {
  const DodoPizzaOftenOrderAnimation({super.key});

  @override
  State<DodoPizzaOftenOrderAnimation> createState() =>
      _DodoPizzaOftenOrderAnimationState();
}

//run this page on web, it is more beautiful on web
class _DodoPizzaOftenOrderAnimationState
    extends State<DodoPizzaOftenOrderAnimation> {
  bool animateRight = false;
  bool animateLeft = false;
  PageController pageViewController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      pageViewController = PageController(
          viewportFraction:
              MediaQuery.of(context).size.width >= 600 ? 0.250 : 0.750);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text("Dodo pizza often order animation"),
        ),
        body: Column(children: [
          const SizedBox(height: 50),
          SizedBox(
              height: 120,
              width: MediaQuery.of(context).size.width,
              child: Stack(children: [
                AnimatedPositioned(
                    width: MediaQuery.of(context).size.width,
                    height: 105,
                    curve: Curves.fastOutSlowIn,
                    duration: const Duration(milliseconds: 500),
                    top: 7.5,
                    right: animateRight
                        ? 20
                        : animateLeft
                            ? -20
                            : 0,
                    // left: animateLeft ? 10 : 0,
                    child: PageView.builder(
                        controller: pageViewController,
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        padEnds: false,
                        // pageSnapping: false,
                        itemBuilder: (context, index) =>
                            AnimatedDodoContainer(index: index))),
                Positioned(
                    right: 0,
                    bottom: 0,
                    top: 0,
                    child: MouseRegion(
                        onEnter: (v) => setState(() {
                              animateRight = true;
                            }),
                        onExit: (v) => setState(() {
                              animateRight = false;
                            }),
                        child: GestureDetector(
                            onTap: () => pageViewController.nextPage(
                                duration: const Duration(milliseconds: 350),
                                curve: Curves.fastOutSlowIn),
                            onLongPress: () => setState(() {
                                  animateRight = true;
                                }),
                            onLongPressEnd: (v) => setState(() {
                                  animateRight = false;
                                  pageViewController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 350),
                                      curve: Curves.fastOutSlowIn);
                                }),
                            child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 350),
                                opacity: animateRight ? 1.0 : 0.0,
                                curve: Curves.fastOutSlowIn,
                                child: Container(
                                    width: 70,
                                    padding: const EdgeInsets.all(15),
                                    decoration: const BoxDecoration(
                                        color: Colors.transparent),
                                    child: animateRight
                                        ? const Center(
                                            child: Icon(Icons
                                                .arrow_forward_ios_outlined))
                                        : const SizedBox()))))),
                Positioned(
                    left: 0,
                    bottom: 0,
                    top: 0,
                    child: MouseRegion(
                        onEnter: (v) => setState(() {
                              animateLeft = true;
                            }),
                        onExit: (v) => setState(() {
                              animateLeft = false;
                            }),
                        child: GestureDetector(
                            onTap: () => pageViewController.previousPage(
                                duration: const Duration(milliseconds: 350),
                                curve: Curves.fastOutSlowIn),
                            onLongPress: () => setState(() {
                                  animateLeft = true;
                                }),
                            onLongPressEnd: (v) => setState(() {
                                  animateLeft = false;
                                  pageViewController.previousPage(
                                      duration:
                                          const Duration(milliseconds: 350),
                                      curve: Curves.fastOutSlowIn);
                                }),
                            child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 350),
                                opacity: animateLeft ? 1 : 0,
                                curve: Curves.fastOutSlowIn,
                                child: Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: const BoxDecoration(
                                        color: Colors.transparent),
                                    child: animateLeft
                                        ? const Center(
                                            child: Icon(Icons.arrow_back_ios))
                                        : const SizedBox())))))
              ]))
        ]));
  }
}

class AnimatedDodoContainer extends StatefulWidget {
  final int index;

  const AnimatedDodoContainer({super.key, required this.index});

  @override
  State<AnimatedDodoContainer> createState() => _AnimatedDodoContainerState();
}

class _AnimatedDodoContainerState extends State<AnimatedDodoContainer> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        onEnter: (v) => setState(() {
              hovered = true;
            }),
        onExit: (v) => setState(() {
              hovered = false;
            }),
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
                color: Colors.white,
                border: hovered ? Border.all(color: Colors.grey[200]!) : null,
                boxShadow: hovered
                    ? []
                    : [
                        BoxShadow(
                            offset: const Offset(1, -1),
                            blurRadius: 5,
                            color: Colors.grey[200]!),
                        BoxShadow(
                            offset: const Offset(-1, 1),
                            blurRadius: 5,
                            spreadRadius: 1,
                            color: Colors.grey[200]!)
                      ],
                borderRadius: BorderRadius.circular(7)),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: IntrinsicHeight(
                child: Row(children: [
              SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.asset(
                      'assets/dodo_pizza_often_order_pictures/dodo_${widget.index}.jpeg')),
              const SizedBox(width: 10),
              const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("First Text"),
                    SizedBox(height: 10),
                    Text("Second Text")
                  ])
            ]))));
  }
}
