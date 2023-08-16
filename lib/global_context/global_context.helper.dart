import 'package:flutter/material.dart';

class GlobalContextHelper {
  //use in MaterialApp widget
  //check main.dart -> MaterialApp widget
  static late GlobalKey<NavigatorState> globalContext;

  static Future<void> initGlobalContext() async {
    globalContext = GlobalKey<NavigatorState>();
  }
}
