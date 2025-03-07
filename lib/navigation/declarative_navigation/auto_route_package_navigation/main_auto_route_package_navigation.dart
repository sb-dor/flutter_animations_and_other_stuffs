import 'package:flutter/material.dart';
import 'package:flutter_animations_2/navigation/declarative_navigation/auto_route_package_navigation/helper/auto_route_helper.dart';

class MainAutoRoutePackageScreen extends StatefulWidget {
  const MainAutoRoutePackageScreen({super.key});

  @override
  State<MainAutoRoutePackageScreen> createState() =>
      _MainAutoRoutePackageScreenState();
}

class _MainAutoRoutePackageScreenState
    extends State<MainAutoRoutePackageScreen> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
    );
  }
}
