import 'package:flutter/material.dart';

class BetterPerformanceAnimatedBuilder extends StatefulWidget {
  const BetterPerformanceAnimatedBuilder({super.key});

  @override
  State<BetterPerformanceAnimatedBuilder> createState() => _BetterPerformanceAnimatedBuilderState();
}

class _BetterPerformanceAnimatedBuilderState extends State<BetterPerformanceAnimatedBuilder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Offset> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween(
      begin: const Offset(0, 0),
      end: const Offset(0, -50),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceInOut,
      ),
    );

    _animationController.repeat(reverse: true);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Performance animated builder",
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Center(
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: _animation.value,
                    child: child,
                  );
                },
                // it's a child that will be built once and inserted inside builder as a child
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.red,
                  child: const Center(
                    child: Text(
                      "Animated ColoredBox",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
