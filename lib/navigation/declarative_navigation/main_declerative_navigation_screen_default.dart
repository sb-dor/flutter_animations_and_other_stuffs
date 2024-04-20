import 'package:flutter/material.dart';
import 'package:flutter_animations_2/navigation/declarative_navigation/first_screen/first_dec_screen.dart';
import 'package:flutter_animations_2/navigation/declarative_navigation/second_screen/second_dec_screen.dart';

class MainDeclarativeNavigationScreen extends StatefulWidget {
  const MainDeclarativeNavigationScreen({super.key});

  @override
  State<MainDeclarativeNavigationScreen> createState() => _MainDeclarativeNavigationScreenState();
}

class _MainDeclarativeNavigationScreenState extends State<MainDeclarativeNavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => const FirstDecScreen(),
        '/second/screen': (context) => const SecondDecScreen(),
      },
    );
  }
}
