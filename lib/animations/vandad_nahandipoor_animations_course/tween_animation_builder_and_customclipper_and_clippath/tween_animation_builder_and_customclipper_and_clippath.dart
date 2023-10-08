import 'package:flutter/material.dart';

class CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    throw UnimplementedError();
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}

class TweenAnimationBuilderAndCustomClipperAndClipPath extends StatefulWidget {
  const TweenAnimationBuilderAndCustomClipperAndClipPath({Key? key}) : super(key: key);

  @override
  State<TweenAnimationBuilderAndCustomClipperAndClipPath> createState() =>
      _TweenAnimationBuilderAndCustomClipperAndClipPathState();
}

class _TweenAnimationBuilderAndCustomClipperAndClipPathState
    extends State<TweenAnimationBuilderAndCustomClipperAndClipPath> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ClipPath(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
