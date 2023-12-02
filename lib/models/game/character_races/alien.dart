import 'package:flutter/material.dart';
import 'package:flutter_animations_2/models/game/character_helpers/race.dart';

class Alien extends Race {
  Alien({required super.vehicle, required super.weapon});

  @override
  void saySome() {
    debugPrint("I'm alien");
  }

  @override
  void walk() {
    // TODO: implement walk
  }

  @override
  String body() {
    // TODO: implement nameOfCloth
    throw UnimplementedError();
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
}
