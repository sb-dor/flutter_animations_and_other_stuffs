// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'auto_route_helper.dart';

/// generated route for
/// [AutoRouteFirstScreen]
class AutoRouteFirstRoute extends PageRouteInfo<void> {
  const AutoRouteFirstRoute({List<PageRouteInfo>? children})
      : super(
          AutoRouteFirstRoute.name,
          initialChildren: children,
        );

  static const String name = 'AutoRouteFirstRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AutoRouteFirstScreen();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<AutoRouteSecondRouteArgs>(
          orElse: () => AutoRouteSecondRouteArgs(id: pathParams.getInt('id')));
      return AutoRouteSecondScreen(
        key: args.key,
        id: args.id,
      );
    },
  );
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
