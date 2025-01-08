import 'package:flutter/material.dart';

class HeartAnimationPage extends StatelessWidget {
  const HeartAnimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: AnimatedHeart()));
  }
}

class AnimatedHeart extends StatefulWidget {
  const AnimatedHeart({super.key});

  @override
  State<AnimatedHeart> createState() => _AnimatedHeartState();
}

class _AnimatedHeartState extends State<AnimatedHeart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<Color?> _colorAnimation;
  bool isFav = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    //from documentation
    _sizeAnimation = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 30, end: 40),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 50, end: 60),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 40, end: 30),
          weight: 50.0,
        )
      ],
    ).animate(_controller);

    _colorAnimation = ColorTween(begin: Colors.grey[400], end: Colors.red)
        .animate(_controller);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isFav = true;
        });
      }
      if (status == AnimationStatus.dismissed) {
        setState(() {
          isFav = false;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) => IconButton(
          onPressed: () =>
              isFav ? _controller.reverse() : _controller.forward(),
          icon: Icon(Icons.favorite,
              color: _colorAnimation.value, size: _sizeAnimation.value)),
    );
  }
}
