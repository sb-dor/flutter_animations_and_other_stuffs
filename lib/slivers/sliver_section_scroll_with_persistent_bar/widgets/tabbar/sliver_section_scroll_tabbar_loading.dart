import 'package:flutter/material.dart';
import 'package:flutter_animations_2/widgets/shimmer_container.dart';

class SliverSectionScrollTabBarLoading extends StatelessWidget {
  const SliverSectionScrollTabBarLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.only(top: 10),
      height: 55,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Center(
          child: Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: ShimmerContainer(
              width: 110,
              height: 35,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        itemCount: 4,
      ),
    );
  }
}
