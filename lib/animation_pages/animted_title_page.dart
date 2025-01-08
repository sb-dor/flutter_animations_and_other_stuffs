import 'package:flutter/material.dart';

class AnimatedTitlePage extends StatelessWidget {
  const AnimatedTitlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const AnimatedTitle()),
    );
  }
}

class AnimatedTitle extends StatefulWidget {
  const AnimatedTitle({super.key});

  @override
  State<AnimatedTitle> createState() => _AnimatedTitleState();
}

class _AnimatedTitleState extends State<AnimatedTitle> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 500),
        curve: Curves.bounceInOut,
        builder: (BuildContext context, val, Widget? child) {
          return Padding(padding: EdgeInsets.only(left: val * 10), child: child!);
        },
        child: const Text("Hello world"));
  }
}
