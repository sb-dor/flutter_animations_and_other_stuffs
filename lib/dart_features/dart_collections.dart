import 'dart:developer';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_animations_2/delivery_food_ui/screens/home_screen/home_screen.dart';
import 'package:collection/collection.dart';
import 'package:flutter_animations_2/models/product.dart';

enum RouteNames { home }

class DartCollections {
  DartCollections();

  static generateRoute(RouteNames routeNames, BuildContext context) {
    late Widget route;
    switch (routeNames) {
      case RouteNames.home:
        route = const HomeScreen();
    }
    _generateRoute(context: context, page: route);
  }

  static _generateRoute(
          {required BuildContext context, required Widget page}) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => page));

  static void hashMap() {
    Map<String, dynamic> hashMap = HashMap();

    hashMap['hashed_name'] = "Avaz";

    log("hashed_name: ${hashMap.containsKey('hashed_name')}");
  }

  static all() {
    //in dart everything is a object like string or integer
    List<Object> listOfObjects = ["1", 2, const HomeScreen(), true];

    List<Object> list = [
      1,
      [1, 2, 4],
      2
    ];
  }

  static list() {
    var list1 = [12, 12, 4];
    var list2 = [12, 12, 3];
    debugPrint(
        "list cheker: ${const ListEquality().equals(list1, list2)}"); //check that both list are same

    List<int> forSort = [1, 54, 3, 34, 6, 7];

    List<Product> prods = [
      Product(id: 3, price: 12, name: 'name'),
      Product(id: 2, price: 11, name: 'name'),
      Product(id: 1, price: 10, name: 'name'),
    ];

    prods.sort((a, b) => a.price.compareTo(b.price));

    for (var element in prods) {
      debugPrint("product: ${element.toJson()}");
    }
  }
}
