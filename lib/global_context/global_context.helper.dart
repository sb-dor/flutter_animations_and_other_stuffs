import 'package:flutter/material.dart';

class GlobalContextHelper {
  //use in MaterialApp widget
  //check animated_drag_drop_app.dart -> MaterialApp widget
  static GlobalKey<NavigatorState> globalNavigatorContext = GlobalKey<NavigatorState>();

  static GlobalKey<ScaffoldMessengerState> globalNavigatorSContext =
      GlobalKey<ScaffoldMessengerState>();
}
