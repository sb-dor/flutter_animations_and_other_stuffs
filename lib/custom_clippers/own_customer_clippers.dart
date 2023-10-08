import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    //custom clipper always starts in (x,y) -> (0,0) : coordinates

    // for example you have a rectangle and the start of that is the start of line

    //here's start
    // |
    // _____
    // |   |
    // |___|

    //method moveTo is using for moving path for some coordinates
    //method lineTo creates line till the coordinates

    //creates a triangle
    // path.moveTo(size.width / 2, 0);
    // path.lineTo(0, size.height);
    // path.lineTo(size.width, size.height);

    //the quadraticBezierTo is for curving the line formula : (widthForCuring, heightForCurving, widthStart, widthEnd)
    // path.moveTo(size.width / 2, 0);
    // path.lineTo(0, size.height);
    // path.quadraticBezierTo(size.width / 2, size.height / 2, size.width, size.height);

    ////the quadraticBezierTo is for curving the line formula
    // : (firstWidthForCuring, firstHeightForCurving, secondWidthForCuring, secondHeightForCurving, widthStart, widthEnd)
    // path.moveTo(size.width / 2, 0);
    // path.lineTo(0, size.height - 20);
    // path.cubicTo(size.width / 2, size.height / 2, size.width - 50, size.height + 50, size.width,
    //     size.height - 20);

    //for adding radius use method arcToPoint. you should write position where radius will end

    // path.moveTo(0, size.height / 2);
    // path.lineTo(0, size.height - 10);
    // path.arcToPoint(Offset(10, size.height), radius: const Radius.circular(10), clockwise: false);
    // path.lineTo(size.width - 10, size.height);
    // path.arcToPoint(Offset(size.width, size.height - 10),
    //     radius: const Radius.circular(10), clockwise: false);
    // path.lineTo(size.width, size.height - (size.height - 10));
    // path.arcToPoint(Offset(size.width - 10, 0),
    //     radius: const Radius.circular(10), clockwise: false);
    // path.lineTo(size.width - (size.width - 10), 0);
    // path.arcToPoint(Offset(0, size.height - (size.height - 10)),
    //     radius: const Radius.circular(10), clockwise: false);
    // path.close();

    //start
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width / 3, size.height / 3);
    path.lineTo(0, size.height / 2.7);
    path.lineTo(size.width / 3, size.height / 2);
    path.lineTo(0, size.height);
    path.lineTo(size.width / 2, size.height / 2);
    path.lineTo(size.width, size.height);

    path.lineTo(size.width / 3, size.height - (size.height / 2));
    path.lineTo(size.width, size.height - (size.height / 3));
    path.lineTo(size.width - (size.width / 3), size.height / 3);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class OwnCustomClippers extends StatefulWidget {
  const OwnCustomClippers({Key? key}) : super(key: key);

  @override
  State<OwnCustomClippers> createState() => _OwnCustomClippersState();
}

class _OwnCustomClippersState extends State<OwnCustomClippers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ClipPath(
          clipper: MyCustomClipper(),
          child: Container(
            width: 200,
            height: 200,
            color: Colors.pink,
          ),
        ),
      ),
    );
  }
}
