import 'package:collection/collection.dart';

class Product {
  int id;
  int? qty;
  int price;
  String name;

  Product(
      {required this.id, required this.price, required this.name, this.qty});
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
