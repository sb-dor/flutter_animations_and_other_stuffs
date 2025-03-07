import 'package:flutter/material.dart';
import 'package:flutter_animations_2/navigation/declarative_navigation/go_router_dec_navigation/first_screen/first_gorouter_dec_screen.dart';
import 'package:flutter_animations_2/navigation/declarative_navigation/go_router_dec_navigation/second_screen/second_gorouter_dec_screen.dart';
import 'package:go_router/go_router.dart';

import 'third_screen/third_gorouter_dec_screen.dart';

// it's better to use names routes in your go routes
final GoRouter _mainGoRouterDecNav = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const FirstGoRouterDevScreen(),
      routes: [
        GoRoute(
          // whenever you use params in order to send something you have to use this type of annotation
          path: 'secondscreen/:number',
          name: "nameforsecondscreen",
          builder: (context, state) {
            // assert(state.extra is Map<String, String>, "Error again");
            final data = state.pathParameters;
            return SecondGoRouterDecScreen(
              comingNumber: int.tryParse("${data['number'] ?? 0}") ?? 0,
            );
          },
        ),
        GoRoute(
          path: 'thirdscreen/:comingId/endpoint/:comingIdd',
          name: "nameforthirdscreen",
          builder: (context, state) {
            int comingId =
                int.tryParse("${state.pathParameters['comingId']}") ?? 0;
            return ThirdGoRouterDecScreen(
              id: comingId,
            );
          },
        ),
      ],
    )
  ],
);

class MainGoRouterDecNavigation extends StatefulWidget {
  const MainGoRouterDecNavigation({super.key});

  @override
  State<MainGoRouterDecNavigation> createState() =>
      _MainGoRouterDecNavigationState();
}

class _MainGoRouterDecNavigationState extends State<MainGoRouterDecNavigation> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _mainGoRouterDecNav,
    );
  }
}
