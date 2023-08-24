import 'package:flutter/material.dart';

class SliverPersistentHeaderDelegateWidget extends SliverPersistentHeaderDelegate {
  final Widget child;

  SliverPersistentHeaderDelegateWidget({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color:overlapsContent ? Colors.red :  Colors.white, child: child);
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 100;

  @override
  // TODO: implement minExtent
  double get minExtent => 100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
