import 'package:freezed_annotation/freezed_annotation.dart';

part 'excel_converter_product.freezed.dart';

part 'excel_converter_product.g.dart';

@freezed
class ExcelConverterProduct with _$ExcelConverterProduct {
  const ExcelConverterProduct._(); // for creating you own functions

  factory ExcelConverterProduct({
    int? id,
    String? barcode,
    String? name,
    @JsonKey(name: "category_name") String? categoryName,
    double? price,
    @JsonKey(name: "old_price") double? oldPrice,
    @JsonKey(name: "pack_qty") double? packQty,
    @JsonKey(name: "product_type_name") String? productTypeName,
    String? description,
    // represents all fields for(picture_original, picture, thumb, icon )
    String? picture,
    // represents all fields for(pic2_orig, pic2, thumb2, icon2 )
    String? thumb2,
    @JsonKey(name: "created_at") String? createdAt,
  }) = _ExcelConverterProduct;

  factory ExcelConverterProduct.fromJson(Map<String, Object?> json) =>
      _$ExcelConverterProductFromJson(json);

  factory ExcelConverterProduct.fromJsonExcel(Map<String, dynamic> json) {
    return ExcelConverterProduct(
      id: int.tryParse("${json['id']}"),
      barcode: json['barcode']?.toString(),
      name: json['name'] == null
          ? null
          : "${json['name']}"
              .replaceAllMapped(
                RegExp(r'^\s*"(.*)"\s*$'),
                (match) => match.group(1)!, // Use the first captured group
              )
              .replaceAll('""', '"'),
      categoryName: json['category_name'] == null
          ? null
          : "${json['category_name']}"
              .replaceAllMapped(
                RegExp(r'^\s*"(.*)"\s*$'),
                (match) => match.group(1)!, // Use the first captured group
              )
              .replaceAll('""', '"'),
      price: double.tryParse("${json['price']}"),
      oldPrice: double.tryParse("${json['old_price']}"),
      packQty: double.tryParse("${json['pack_qty']}"),
      description: json['description'] == null
          ? null
          : "${json['description']}"
              .replaceAllMapped(
                RegExp(r'^\s*"(.*)"\s*$'),
                (match) => match.group(1)!, // Use the first captured group
              )
              .replaceAll('""', '"'),
      productTypeName: json['unit']?.toString(),
    );
  }

  Map<String, dynamic> toJsonWithoutId() {
    return {
      "barcode": (barcode?.trim() ?? '').isEmpty ? null : barcode?.trim(),
      "name": (name?.trim() ?? '').isEmpty ? null : name?.trim(),
      "price": price,
      "old_price": oldPrice,
      "pack_qty": packQty,
      "description": (description ?? '').isEmpty ? null : description?.trim(),
      // represents all fields for(picture_original, picture, thumb, icon )
      // "picture": picture,
      // represents all fields for(pic2_orig, pic2, thumb2, icon2 )
      // "thumb": thumb2,
    };
  }

  Map<String, dynamic> toJsonCheckBarcode() {
    return {
      "id": id,
      "barcode": (barcode?.trim() ?? '').isEmpty ? null : barcode?.trim(),
    };
  }
}
