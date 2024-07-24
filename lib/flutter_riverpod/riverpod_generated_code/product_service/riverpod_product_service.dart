import 'package:flutter_animations_2/flutter_riverpod/riverpod_generated_code/riverpod_generated_code_state_managements/product_filter_model.dart';

class RiverpodProductServiceModel {
  final String name;
  final double price;

  RiverpodProductServiceModel({required this.name, required this.price});
}

class ProductService {
  Future<List<RiverpodProductServiceModel>> getProducts(ProductFilterModel filter) async {
    // Simulate a network call and filter the products
    await Future.delayed(Duration(seconds: 2));

    // Sample data
    List<RiverpodProductServiceModel> allProducts = [
      RiverpodProductServiceModel(name: 'Product 1', price: 100),
      RiverpodProductServiceModel(name: 'Product 2', price: 200),
      RiverpodProductServiceModel(name: 'Product 3', price: 300),
    ];

    return allProducts
        .where((product) =>
            (filter.query == null || product.name.contains(filter.query!)) &&
            (filter.minPrice == null || product.price >= filter.minPrice!) &&
            (filter.maxPrice == null || product.price <= filter.maxPrice!))
        .toList();
  }
}
