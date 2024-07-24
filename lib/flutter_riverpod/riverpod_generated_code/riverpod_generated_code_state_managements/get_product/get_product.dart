import 'package:flutter_animations_2/flutter_riverpod/riverpod_generated_code/product_service/riverpod_product_service.dart';
import 'package:flutter_animations_2/flutter_riverpod/riverpod_generated_code/riverpod_generated_code_state_managements/product_filter/riverpod_product_filter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_product.g.dart';

@riverpod
class GetProduct extends _$GetProduct {
  @override
  Future<List<RiverpodProductServiceModel>> build() async {
    final filter = ref.watch(riverpodProductFilterProvider.notifier).productFilterModel;

    return ProductService().getProducts(filter);
  }

  void refresh() {
    ref.invalidateSelf();
  }
}
