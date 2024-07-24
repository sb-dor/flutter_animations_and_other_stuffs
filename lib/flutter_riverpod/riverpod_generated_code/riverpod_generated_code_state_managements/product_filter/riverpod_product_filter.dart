import 'package:flutter_animations_2/flutter_riverpod/riverpod_generated_code/riverpod_generated_code_state_managements/product_filter_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'riverpod_product_filter.g.dart';

@riverpod
class RiverpodProductFilter extends _$RiverpodProductFilter {
  late ProductFilterModel productFilterModel;

  @override
  void build() {
    productFilterModel = ProductFilterModel.initial();
  }

  void update(ProductFilterModel model) {
    productFilterModel = model;
  }
}
