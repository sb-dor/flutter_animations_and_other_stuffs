import 'package:flutter/material.dart';
import 'package:flutter_animations_2/models/game/character_helpers/cloth.dart';
import 'package:flutter_animations_2/models/game/character_helpers/vehicle.dart';
import 'package:flutter_animations_2/models/game/character_helpers/weapon.dart';

abstract class Race implements Cloth {
  void saySome();

  void walk();

  //if function has body the class that extends main class does not override that func
  void food() {
    debugPrint("they both eat meat");
  }

  Weapon weapon;

  Vehicle vehicle;

  Race({required this.vehicle, required this.weapon});
}
