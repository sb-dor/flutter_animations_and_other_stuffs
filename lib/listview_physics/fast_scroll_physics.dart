import 'package:flutter/material.dart';

class FastScrollPhysics extends ScrollPhysics {
  const FastScrollPhysics({ScrollPhysics? parent}) : super(parent: parent);

  @override
  FastScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return FastScrollPhysics(parent: buildParent(ancestor)!);
  }

  @override
  SpringDescription get spring => const SpringDescription(
    mass: 80,
    stiffness: 80,
    damping: 0.5,
  );
}
