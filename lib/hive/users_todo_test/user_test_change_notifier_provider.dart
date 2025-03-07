import 'package:flutter/material.dart';

class UserTestChangeNotifierProvider<Provider extends ChangeNotifier> extends InheritedNotifier {
  final Provider provider;

  const UserTestChangeNotifierProvider({
    super.key,
    required super.child,
    required this.provider,
  }) : super(notifier: provider);

  static Provider? read<Provider extends ChangeNotifier>(BuildContext context) {
    final element =
        context.getElementForInheritedWidgetOfExactType<UserTestChangeNotifierProvider<Provider>>();

    if (element?.widget is UserTestChangeNotifierProvider<Provider>) {
      return (element?.widget as UserTestChangeNotifierProvider<Provider>).provider;
    }

    throw Exception("Provider with type ${Provider.runtimeType} does not exist");
  }

  static Provider? watch<Provider extends ChangeNotifier>(BuildContext context) {
    final changeNotifier =
        context.dependOnInheritedWidgetOfExactType<UserTestChangeNotifierProvider<Provider>>();

    if (changeNotifier == null) {
      throw Exception("Provider with type ${Provider.runtimeType} does not exist");
    }

    return changeNotifier.provider;
  }
}
