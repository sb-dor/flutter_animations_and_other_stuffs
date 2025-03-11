import 'package:flutter_animations_2/slivers/surf_sync_scroll/models/surf_product.dart';

final class SurfCategory {
  const SurfCategory({
    required this.id,
    required this.title,
    required this.products,
  });

  final String id;
  final String title;
  final List<SurfProduct> products;
}
