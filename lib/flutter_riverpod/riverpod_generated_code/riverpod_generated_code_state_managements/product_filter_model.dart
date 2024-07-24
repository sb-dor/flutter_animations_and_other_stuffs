class ProductFilterModel {
  final String? query;
  final int? minPrice;
  final int? maxPrice;

  ProductFilterModel({this.query, this.minPrice, this.maxPrice});

  factory ProductFilterModel.initial() {
    return ProductFilterModel(query: '', minPrice: 0, maxPrice: 10000);
  }
}