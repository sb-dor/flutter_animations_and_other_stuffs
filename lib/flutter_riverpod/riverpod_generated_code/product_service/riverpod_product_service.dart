import 'package:flutter_animations_2/flutter_riverpod/riverpod_generated_code/riverpod_generated_code_state_managements/product_filter_model.dart';

class RiverpodProductServiceModel {
  final String name;
  final double price;

  RiverpodProductServiceModel({required this.name, required this.price});
}

class ProductService {
  Future<List<RiverpodProductServiceModel>> getProducts(ProductFilterModel? filter) async {
    // Simulate a network call and filter the products
    await Future.delayed(const Duration(seconds: 2));

    // Sample data
    List<RiverpodProductServiceModel> allProducts = [
      RiverpodProductServiceModel(name: 'Apple', price: 100),
      RiverpodProductServiceModel(name: 'Banana', price: 200),
      RiverpodProductServiceModel(name: 'Watermelon', price: 300),
    ];

    if (filter == null) return allProducts;

    return allProducts
        .where((product) =>
            product.name.trim().toUpperCase().contains((filter.query ?? '').trim().toUpperCase()) ||
            (product.price >= (filter.minPrice ?? 0.0) &&
                product.price <= (filter.maxPrice ?? 0.0)))
        .toList();
  }
}
