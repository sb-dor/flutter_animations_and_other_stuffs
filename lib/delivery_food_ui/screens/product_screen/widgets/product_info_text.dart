import 'package:flutter/material.dart';
import 'package:flutter_animations_2/delivery_food_ui/core/utils/ui_helper.dart';

class ProductInfoText extends StatelessWidget {
  const ProductInfoText({super.key, required this.text, required this.value});

  final String text;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontSize: rf(12)),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: rf(16),
                height: 1.5,
              ),
        ),
        SizedBox(height: rh(space5x)),
      ],
    );
  }
}
