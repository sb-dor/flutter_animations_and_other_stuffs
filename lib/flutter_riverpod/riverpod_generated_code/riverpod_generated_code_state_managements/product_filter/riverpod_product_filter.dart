import 'package:flutter/cupertino.dart';
import 'package:flutter_animations_2/flutter_riverpod/riverpod_generated_code/riverpod_generated_code_state_managements/get_product/get_product.dart';
import 'package:flutter_animations_2/flutter_riverpod/riverpod_generated_code/riverpod_generated_code_state_managements/product_filter_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'riverpod_product_filter.g.dart';

@riverpod
class RiverpodProductFilter extends _$RiverpodProductFilter {
  @override
  ProductFilterModel build() {
    return ProductFilterModel.initial();
  }

  void updateState(ProductFilterModel model) {
    debugPrint("coming here update");
    state = model;
    ref.read(getProductProvider.notifier).refreshState(filter: model);
  }
}
