import 'package:flutter_animations_2/web_page_with_url/pages/main_web_details_page_with_url.dart';
import 'package:flutter_animations_2/web_page_with_url/pages/main_web_page_with_url.dart';
import 'package:go_router/go_router.dart';

final GoRouter webRouter = GoRouter(
  // initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainWebPageWithUrl(),
      routes: [
        GoRoute(
          name: "detailsName",
          path:
              'details/:anyName/:anySurname/user', // you have to pass data other wise the route will not work
          builder: (context, state) => MainWebDetailsPageWithUrl(
            name: state.pathParameters['anyName'] ?? '',
            sName: state.pathParameters['anySurname'] ?? '',
          ),
        ),
      ],
    ),
  ],
);
