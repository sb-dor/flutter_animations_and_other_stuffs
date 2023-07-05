abstract class Vehicle {
  double speed();
}

class MotoCycle extends Vehicle {
  @override
  double speed() => 200;
}

class SpaceRunner extends Vehicle {
  @override
  double speed() => 210.5;
}
