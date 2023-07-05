import 'package:flutter/cupertino.dart';

abstract class Weapon {
  double? sizeOfBullet;

  void shoot();
}

class Ak47 implements Weapon {
  @override
  double? sizeOfBullet = 20;

  @override
  void shoot() {
    debugPrint("shoot bullet size: $sizeOfBullet");
  }
}

class Bluster implements Weapon {
  @override
  double? sizeOfBullet = 30;

  @override
  void shoot() {
    debugPrint("shoot bullet size: $sizeOfBullet");
  }
}
