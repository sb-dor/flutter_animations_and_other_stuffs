import 'package:flutter_animations_2/flutter_riverpod/riverpod_generated_code/product_service/riverpod_product_service.dart';
import 'package:flutter_animations_2/flutter_riverpod/riverpod_generated_code/riverpod_generated_code_state_managements/product_filter_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_product.g.dart';

@riverpod
class GetProduct extends _$GetProduct {
  @override
  Future<List<RiverpodProductServiceModel>> build() async {
    return await ProductService().getProducts(null);
  }

  void refreshState({ProductFilterModel? filter}) async {
    if (filter == null) {
      build();
      return;
    }
    final list = await ProductService().getProducts(filter);
    state = AsyncValue.data(list);
  }
}
