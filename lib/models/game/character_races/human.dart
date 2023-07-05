import 'package:flutter/material.dart';
import 'package:flutter_animations_2/models/game/character_helpers/race.dart';
import 'package:flutter_animations_2/models/game/character_helpers/vehicle.dart';
import 'package:flutter_animations_2/models/game/character_helpers/weapon.dart';

class Human extends Race {
  Human({required super.weapon, required super.vehicle});

  @override
  void saySome() {
    debugPrint("I'm human");
  }

  @override
  void walk() {
    // TODO: implement walk
  }

  @override
  String pants() {
    // TODO: implement pants
    throw UnimplementedError();
  }

  @override
  String shoos() {
    // TODO: implement shoos
    throw UnimplementedError();
  }

  @override
  String body() {
    // TODO: implement body
    throw UnimplementedError();
  }
}
