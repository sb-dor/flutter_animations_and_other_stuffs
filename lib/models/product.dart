//ignore_for_file: non_constant_identifier_names

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';

class Product {
  int id;
  double? qty;
  int price;
  double? pack_qty;
  String name;

  Product(
      {required this.id,
      required this.price,
      required this.name,
      this.qty,
      this.pack_qty});
}

extension NameOfExtension on List<Product> {
  void addProductList(Product product) {
    final findItem = firstWhereOrNull((element) => element.id == product.id);
    if (findItem != null) {
      findItem.qty = (findItem.qty ?? 0) + 1;
    } else {
      add(product);
    }
  }

  void deleteProductList(Product product) {
    removeWhere((element) => element.id == product.id);
  }
}

extension QtyToDoubleAndGet on Product {
  double to_double() {
    return (qty ?? 0) / (pack_qty ?? 0);
  }

  double getFromDouble() {
    double qty_solved = 0;
    debugPrint("qty: $qty");
    int first_qty = (qty ?? 0.0).toInt();
    debugPrint("f qty: $first_qty");
    double second_qty =
        double.parse(((qty ?? 0.0) - first_qty).toStringAsFixed(2));
    debugPrint("s qty: $second_qty");
    qty_solved += first_qty * (pack_qty ?? 0);
    qty_solved += second_qty * (pack_qty ?? 0);
    return qty_solved;
  }
}
