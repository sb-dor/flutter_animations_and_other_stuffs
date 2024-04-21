import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations_2/navigation/declarative_navigation/auto_route_package_navigation/first_screen/auto_route_first_screen.dart';
import 'package:flutter_animations_2/navigation/declarative_navigation/auto_route_package_navigation/second_screen/auto_route_second_screen.dart';

part 'auto_route_helper.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: AutoRouteFirstRoute.page,
          path: "/"
        ),
        AutoRoute(
          page: AutoRouteSecondRoute.page,
          path: "/secondscreen/:id"
        )
      ];
}
