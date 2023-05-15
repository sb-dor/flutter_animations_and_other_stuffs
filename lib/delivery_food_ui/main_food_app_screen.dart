import 'package:flutter/material.dart';
import 'package:flutter_animations_2/delivery_food_ui/core/theme/app_theme.dart';
import 'package:flutter_animations_2/delivery_food_ui/core/utils/size_config.dart';
import 'package:flutter_animations_2/delivery_food_ui/screens/splash_screen.dart';


class MainFoodAppScreen extends StatelessWidget {
  const MainFoodAppScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizeConfiguration(
      builder: (_) => MaterialApp(
        title: 'Foodie',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        home: const SplashScreen(),
      ),
    );
  }
}
