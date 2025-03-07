import 'package:flutter/material.dart';

import 'first_screen/first_dec_screen.dart';
import 'second_screen/second_dec_screen.dart';

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
