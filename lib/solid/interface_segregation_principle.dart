//instead of creating big interface that do a lot of stuff
abstract class Shape {
  void drawLine();

  void drawCircle();

  void drawRect();
}

//you should create interfaces that do their own job
//for ex:

abstract class LineShape {
  void drawLine();
}

abstract class CircleShape {
  void drawCircle();
}

abstract class RectShape {
  void drawRect();
}
//even one class can implement one or more classes

//
class Line implements LineShape {
  @override
  void drawLine() {
    // TODO: implement drawLine
  }
}

class Circle implements CircleShape {
  @override
  void drawCircle() {
    // TODO: implement drawCircle
  }
}

class Rect implements RectShape {
  @override
  void drawRect() {
    // TODO: implement drawRect
  }
}
