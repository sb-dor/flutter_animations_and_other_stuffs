import 'package:flutter/cupertino.dart';
import 'package:flutter_animations_2/models/game/character_helpers/race.dart';
import 'package:flutter_animations_2/models/game/character_helpers/vehicle.dart';
import 'package:flutter_animations_2/models/game/character_helpers/weapon.dart';
import 'package:flutter_animations_2/models/game/character_races/alien.dart';
import 'package:flutter_animations_2/models/game/character_races/human.dart';

class MainCharacter {
  Race? race;

  MainCharacter(String raceType) {
    if (raceType == 'Human') {
      race = Human(weapon: Ak47(), vehicle: MotoCycle());
      debugPrint("human weapon: ${race?.weapon.runtimeType}");
    } else {
      race = Alien(weapon: Bluster(), vehicle: SpaceRunner());
      debugPrint("alien weapon: ${race?.weapon.runtimeType}");
    }
  }
}
