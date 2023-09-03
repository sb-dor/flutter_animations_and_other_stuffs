import 'package:flutter_animations_2/animation_pages/page_view_with_controller.dart';
import 'package:flutter_animations_2/main.dart';
import 'package:go_router/go_router.dart';

class FlutterDeepLinkingRoute {
  static final goRouter = GoRouter(routes: [
    GoRoute(
        path: "/",
        builder: (context, state) {
          return const MainApp();
        },
        routes: [
          GoRoute(
              path: 'start',
              builder: (context, state) {
                return PageViewWithController();
              })
        ])
  ]);
}
