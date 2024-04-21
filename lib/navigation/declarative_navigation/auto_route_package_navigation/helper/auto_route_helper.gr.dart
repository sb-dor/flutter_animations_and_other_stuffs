// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'auto_route_helper.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AutoRouteFirstRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AutoRouteFirstScreen(),
      );
    },
    AutoRouteSecondRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<AutoRouteSecondRouteArgs>(
          orElse: () => AutoRouteSecondRouteArgs(id: pathParams.getInt('id')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AutoRouteSecondScreen(
          key: args.key,
          id: args.id,
        ),
      );
    },
  };
}

/// generated route for
/// [AutoRouteFirstScreen]
class AutoRouteFirstRoute extends PageRouteInfo<void> {
  const AutoRouteFirstRoute({List<PageRouteInfo>? children})
      : super(
          AutoRouteFirstRoute.name,
          initialChildren: children,
        );

  static const String name = 'AutoRouteFirstRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AutoRouteSecondScreen]
class AutoRouteSecondRoute extends PageRouteInfo<AutoRouteSecondRouteArgs> {
  AutoRouteSecondRoute({
    Key? key,
    required int id,
    List<PageRouteInfo>? children,
  }) : super(
          AutoRouteSecondRoute.name,
          args: AutoRouteSecondRouteArgs(
            key: key,
            id: id,
          ),
          rawPathParams: {'id': id},
          initialChildren: children,
        );

  static const String name = 'AutoRouteSecondRoute';

  static const PageInfo<AutoRouteSecondRouteArgs> page =
      PageInfo<AutoRouteSecondRouteArgs>(name);
}

class AutoRouteSecondRouteArgs {
  const AutoRouteSecondRouteArgs({
    this.key,
    required this.id,
  });

  final Key? key;

  final int id;

  @override
  String toString() {
    return 'AutoRouteSecondRouteArgs{key: $key, id: $id}';
  }
}
