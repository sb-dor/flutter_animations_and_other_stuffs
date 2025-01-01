import 'sliver_product_model.dart';

class SliverCategoryModel {
  final int? id;
  final String? name;
  final List<SliverProductModel>? products;

  SliverCategoryModel({
    this.id,
    this.name,
    this.products,
  });
}
