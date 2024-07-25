import 'package:flutter/cupertino.dart';
import 'package:flutter_animations_2/flutter_riverpod/riverpod_generated_code/product_service/riverpod_product_service.dart';
import 'package:flutter_animations_2/flutter_riverpod/riverpod_generated_code/riverpod_generated_code_state_managements/product_filter/riverpod_product_filter.dart';
import 'package:flutter_animations_2/flutter_riverpod/riverpod_generated_code/riverpod_generated_code_state_managements/product_filter_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_product.g.dart';

@riverpod
class GetProduct extends _$GetProduct {
  List<RiverpodProductServiceModel> list = [];

  @override
  void build() async {
    list = await ProductService().getProducts(null);
  }

  void refresh({ProductFilterModel? filter}) async {
    if (filter == null) {
      build();
      return;
    }
    list = await ProductService().getProducts(filter);
    state = list;
  }
}
