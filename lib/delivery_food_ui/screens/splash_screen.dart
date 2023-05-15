import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animations_2/animations/navigation/page_transition_animation.dart';
import 'package:flutter_animations_2/delivery_food_ui/core/utils/navigation.dart';

import 'home_screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _next();
    super.initState();
  }

  _next() {
    Timer(
      const Duration(milliseconds: 450),
      () {
        Navigation.push(
          context,
          customPageTransition: PageTransition(
            child: const HomeScreen(),
            type: PageTransitionType.fadeIn,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(),
    );
  }
}
