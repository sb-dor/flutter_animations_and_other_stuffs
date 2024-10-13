// dependency inversion principle is exactly same like -> strategy design pattern
// check out in files -> lib/flutter_design_patters/strategy_pattern.dart

// abstraction
abstract class Weapon {
  void shot();
}

// low level module
class Blaster implements Weapon {
  @override
  void shot() {
    // TODO: implement shot
  }
}

// low level module
class Glock implements Weapon {
  @override
  void shot() {
    // TODO: implement shot
  }
}

// high level module
class HighLevelModule {
  final Weapon weapon;

  HighLevelModule(this.weapon);

  void shot() {
    weapon.shot();
  }
}
