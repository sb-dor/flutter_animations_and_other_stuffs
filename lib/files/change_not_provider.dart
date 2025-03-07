import 'package:flutter/cupertino.dart';

class ChangeNotProvider<Model extends ChangeNotifier>
    extends InheritedNotifier {
  final Model model;

  const ChangeNotProvider({
    super.key,
    required this.model,
    required super.child,
  }) : super(notifier: model);

  static Model? watch<Model extends ChangeNotifier>(BuildContext context) {
    final find =
        context.dependOnInheritedWidgetOfExactType<ChangeNotProvider<Model>>();

    if (find == null) {
      // Throw an exception if the provider is not found
      throw Exception(
          'No OwnChangeNotifierProvider found in context for type $Model.');
    }

    return find.model;
  }

  static Model? read<Model extends ChangeNotifier>(BuildContext context) {
    final find = context
        .getElementForInheritedWidgetOfExactType<ChangeNotProvider<Model>>();

    if (find?.widget is ChangeNotProvider<Model>) {
      return (find?.widget as ChangeNotProvider<Model>).model;
    }

    throw Exception(
        'No OwnChangeNotifierProvider found in context for type $Model.');
  }
}
