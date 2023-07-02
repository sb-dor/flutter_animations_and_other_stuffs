import 'package:flutter_animations_2/delivery_food_ui/main_food_app_screen.dart';
import 'package:flutter_animations_2/functions/paginate_list.dart';
import 'package:flutter_animations_2/models/product.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('paginate_list_test', () {
    test('test page with zero item', () {
      List<String> pagList = [];

      List<String> stringList = List.generate(31, (index) => "avaz");

      pagList.addAll(PaginateList.paginateList(wholeList: stringList, currentList: pagList)
          .map((e) => e.toString())
          .toList());

      expect(30, pagList.length);
    });

    test('test page with one item list', () {
      List<String> pagList = ["avaz"];

      List<String> stringList = List.generate(31, (index) => "avaz");

      pagList.addAll(PaginateList.paginateList(wholeList: stringList, currentList: pagList)
          .map((e) => e.toString())
          .toList());

      expect(31, pagList.length);
    });

    test('test page with two item list', () {
      List<String> pagList = ["avaz", "avaz"];

      List<String> stringList = List.generate(31, (index) => "avaz");

      pagList.addAll(PaginateList.paginateList(wholeList: stringList, currentList: pagList)
          .map((e) => e.toString())
          .toList());

      expect(31, pagList.length);
    });

    test('test page with 27 item list', () {
      List<String> pagList = List.generate(27, (index) => "avaz");

      List<String> stringList = List.generate(31, (index) => "avaz");

      pagList.addAll(PaginateList.paginateList(wholeList: stringList, currentList: pagList)
          .map((e) => e.toString())
          .toList());

      expect(31, pagList.length);
    });

    test('test page with 30 item list', () {
      List<String> pagList = List.generate(30, (index) => "avaz");

      List<String> stringList = List.generate(31, (index) => "avaz");

      pagList.addAll(PaginateList.paginateList(wholeList: stringList, currentList: pagList)
          .map((e) => e.toString())
          .toList());

      expect(31, pagList.length);
    });

    test('test page with 31 item list', () {
      List<String> pagList = List.generate(31, (index) => "avaz");

      List<String> stringList = List.generate(31, (index) => "avaz");

      pagList.addAll(PaginateList.paginateList(wholeList: stringList, currentList: pagList)
          .map((e) => e.toString())
          .toList());

      expect(31, pagList.length);
    });

    test('testing with perPage -> 16 | with zero item list', () {
      List<String> pagList = [];

      List<String> stringList = List.generate(31, (index) => "avaz");

      pagList.addAll(
          PaginateList.paginateList(wholeList: stringList, currentList: pagList, perPage: 16)
              .map((e) => e.toString())
              .toList());

      expect(16, pagList.length);
    });

    test('testing with perPage -> 16 | with 14 item list', () {
      List<String> pagList = List.generate(14, (index) => "avaz");

      List<String> stringList = List.generate(31, (index) => "avaz");

      pagList.addAll(
          PaginateList.paginateList(wholeList: stringList, currentList: pagList, perPage: 16)
              .map((e) => e.toString())
              .toList());

      expect(30, pagList.length);
    });

    test('testing with perPage -> 16 | with 15 item list', () {
      List<String> pagList = List.generate(15, (index) => "avaz");

      List<String> stringList = List.generate(31, (index) => "avaz");

      pagList.addAll(
          PaginateList.paginateList(wholeList: stringList, currentList: pagList, perPage: 16)
              .map((e) => e.toString())
              .toList());

      expect(31, pagList.length);
    });

    test('testing with perPage -> 16 | with 21 item list', () {
      List<String> pagList = List.generate(15, (index) => "avaz");

      List<String> stringList = List.generate(31, (index) => "avaz");

      pagList.addAll(
          PaginateList.paginateList(wholeList: stringList, currentList: pagList, perPage: 16)
              .map((e) => e.toString())
              .toList());

      expect(31, pagList.length);
    });

    test('testing with perPage -> 45 | with zero item list', () {
      List<String> pagList = [];

      List<String> stringList = List.generate(31, (index) => "avaz");

      pagList.addAll(
          PaginateList.paginateList(wholeList: stringList, currentList: pagList, perPage: 45)
              .map((e) => e.toString())
              .toList());

      expect(31, pagList.length);
    });

    test('testing Product with perPage -> 15 | with zero item list', () {
      List<Product> pagList = [];

      // pagList.where((element) => false)

      List<Product> stringList = List.generate(31, (index) => Product(id: 1, price: 1, name: "1"));

      pagList.addAll(PaginateList.paginateList<Product>(
              wholeList: stringList, currentList: pagList, perPage: 15)
          .map((e) => Product(id: e.id, price: e.price, name: e.name))
          .toList());

      expect(15, pagList.length);
    });

    test('testing Product with perPage -> 30 | with 17 item list', () {
      List<Product> pagList = List.generate(17, (index) => Product(id: 1, price: 1, name: "1"));

      // pagList.where((element) => false)

      List<Product> stringList = List.generate(60, (index) => Product(id: 1, price: 1, name: "1"));

      pagList.addAll(PaginateList.paginateList<Product>(
              wholeList: stringList, currentList: pagList, perPage: 30)
          .map((e) => Product(id: e.id, price: e.price, name: e.name))
          .toList());

      expect(47, pagList.length);
    });

    test('testing Product with perPage -> 25 | with 55 item list', () {
      List<Product> pagList = List.generate(46, (index) => Product(id: 1, price: 1, name: "1"));

      // pagList.where((element) => false)

      List<Product> stringList = List.generate(60, (index) => Product(id: 1, price: 1, name: "1"));

      pagList.addAll(PaginateList.paginateList<Product>(
              wholeList: stringList, currentList: pagList, perPage: 25)
          .map((e) => Product(id: e.id, price: e.price, name: e.name))
          .toList());

      expect(60, pagList.length);
    });

    test('testing Product with perPage -> 25 | with zero item list | try refresh', () {
      List<Product> pagList = [];

      List<Product> stringList = List.generate(60, (index) => Product(id: 1, price: 1, name: "1"));

      pagList = PaginateList.paginateList<Product>(
              wholeList: stringList, currentList: pagList, perPage: 25)
          .map((e) => Product(id: e.id, price: e.price, name: e.name))
          .toList();

      expect(25, pagList.length);
    });
  });
}
