import 'package:flutter/material.dart';

class GlobalContextHelper {
  //use in MaterialApp widget
  //check main.dart -> MaterialApp widget
  static GlobalKey<NavigatorState> globalNavigatorContext = GlobalKey<NavigatorState>();

  static GlobalKey<ScaffoldMessengerState> globalNavigatorSContext =
      GlobalKey<ScaffoldMessengerState>();
}
