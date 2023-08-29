import 'package:flutter/material.dart';

class SliverStateModel {
  List<String> names = ["Red", "Blue", "Yellow", "Pink"];

  List<GlobalKey> horizontalKeys = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];

  var redKey = GlobalKey();
  var blueKey = GlobalKey();
  var yellowKey = GlobalKey();
  var pinkKey = GlobalKey();

  var horizontalScrollController = ScrollController();

  int selectedIndex = 0;

  double bluePos = 0;
  double yellowPos = 0;
  double pinkPos = 0;
}
