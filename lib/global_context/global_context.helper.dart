import 'package:flutter/material.dart';

class GlobalContextHelper {
  static GlobalContextHelper? _instance;

  static GlobalContextHelper get instance => _instance ??= GlobalContextHelper._();

  GlobalContextHelper._();

  //use in MaterialApp widget
  //check animated_drag_drop_app.dart -> MaterialApp widget
  GlobalKey<NavigatorState> globalNavigatorContext = GlobalKey<NavigatorState>();

  GlobalKey<ScaffoldMessengerState> globalNavigatorSContext = GlobalKey<ScaffoldMessengerState>();
}
