import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class OwnKartetoCards {
  final String name;
  final String id;
  Offset? lastOffset;

  OwnKartetoCards(this.name, {this.lastOffset}) : id = const Uuid().v4();

  void initOffset({required Offset offset}) {
    lastOffset = offset;
  }

  static List<OwnKartetoCards> cards = [
    OwnKartetoCards("Hippo"),
    OwnKartetoCards("Lion"),
    OwnKartetoCards("Giraffe"),
    OwnKartetoCards("Giraffe"),
    OwnKartetoCards("Hippo"),
    OwnKartetoCards("Crocodile"),
    OwnKartetoCards("Giraffe"),
    OwnKartetoCards("Lion"),
    OwnKartetoCards("Crocodile"),
    OwnKartetoCards("Crocodile"),
    OwnKartetoCards("Crocodile"),
    OwnKartetoCards("Lion"),
    OwnKartetoCards("Crocodile"),
  ];
}
