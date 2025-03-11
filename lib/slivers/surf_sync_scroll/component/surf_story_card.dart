import 'package:flutter/material.dart';

class SurfStoryCard extends StatelessWidget {
  const SurfStoryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 124,
      width: 108,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.grey[300],
        ),
      ),
    );
  }
}
