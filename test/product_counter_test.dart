import 'package:flutter_animations_2/models/product.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("group testing products", () {
    test('check object parse', () {
      Product product = Product(id: 1, price: 10, name: "avaz", qty: 21, pack_qty: 15);

      double parse = product.parsSelectedQtyToDouble();

      expect(parse, 1.4);
    });

    test('check object reparse', () {
      Product product = Product(id: 1, price: 10, name: "avaz", qty: 19, pack_qty: 15);

      int repars = product.reParseSelectedQty();

      expect(repars, 19);
    });
  });
}
