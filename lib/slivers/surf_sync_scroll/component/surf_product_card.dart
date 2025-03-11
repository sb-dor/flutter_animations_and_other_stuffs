import 'package:flutter/material.dart';
import 'package:flutter_animations_2/slivers/surf_sync_scroll/models/surf_product.dart';

class SurfProductCard extends StatelessWidget {
  const SurfProductCard({
    super.key,
    required this.product,
  });

  final SurfProduct product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: product.isLargeCard ? 456 : 148,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(32),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Center(
            child: Text(
              product.title,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
