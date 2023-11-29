import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final goRouter = GoRouter(routes: [
  GoRoute(
      // there always should be "/" route
      path: "/",
      builder: (context, state) {
        return const _HomePage();
      },
      routes: [
        GoRoute(
            path: 'profile',
            builder: (context, state) {
              debugPrint("other parameters: ${state.pathParameters}");
              debugPrint("fullPath ${state.fullPath}");
              debugPrint('extra: ${state.extra}');
              debugPrint("uri : ${state.uri}");
              debugPrint("uri query: ${state.uri.query}");
              debugPrint("uri query parameters: ${state.uri.queryParameters}");
              return const _Profile();
            })
      ])
]);

class FlutterDeepLinkPage extends StatelessWidget {
  const FlutterDeepLinkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Home page")));
  }
}

class _Profile extends StatelessWidget {
  const _Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Profile")));
  }
}
