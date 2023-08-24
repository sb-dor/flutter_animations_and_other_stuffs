import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverSection extends MultiSliver {
  SliverSection(
      {Key? key,
      required String title,
      Color headerColor = Colors.white,
      Color titleColor = Colors.black,
      required List<Widget> items})
      : super(key: key, pushPinnedChildren: false, children: items);
}
