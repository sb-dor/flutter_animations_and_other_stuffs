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
              var param = state.uri.queryParameters;
              return _Profile(
                age: param['avaz'],
                birthDay: param['birthday'],
                name: param['name'],
              );
            })
      ])
]);

class FlutterDeepLinkPage extends StatelessWidget {
  const FlutterDeepLinkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Home page")));
  }
}

class _Profile extends StatelessWidget {
  final String? age;
  final String? name;
  final String? birthDay;

  const _Profile({this.age, this.name, this.birthDay});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Profile: $name")),
        body: Center(child: Text("Age: $age | birthday: $birthDay")));
  }
}
