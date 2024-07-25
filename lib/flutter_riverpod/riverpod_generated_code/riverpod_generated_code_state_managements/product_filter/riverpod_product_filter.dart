import 'package:flutter/cupertino.dart';
import 'package:flutter_animations_2/flutter_riverpod/riverpod_generated_code/riverpod_generated_code_state_managements/get_product/get_product.dart';
import 'package:flutter_animations_2/flutter_riverpod/riverpod_generated_code/riverpod_generated_code_state_managements/product_filter_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'riverpod_product_filter.g.dart';

@riverpod
class RiverpodProductFilter extends _$RiverpodProductFilter {
  late ProductFilterModel productFilterModel;

  @override
  void build() {
    debugPrint("coming here build");
    productFilterModel = ProductFilterModel.initial();
  }

  void update(ProductFilterModel model) {
    debugPrint("coming here update");
    productFilterModel = model;
    ref.read(getProductProvider.notifier).refresh(filter: productFilterModel);
  }
}
