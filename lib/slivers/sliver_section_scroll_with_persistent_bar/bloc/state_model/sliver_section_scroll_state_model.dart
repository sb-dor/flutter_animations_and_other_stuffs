import 'package:flutter/material.dart';
import 'package:flutter_animations_2/slivers/sliver_section_scroll_with_persistent_bar/models/sliver_category_model.dart';

class SliverSectionScrollStateModel {
  final List<SliverCategoryModel> categories;
  final List<GlobalKey> globalKeys;
  final List<String> sliverTitles;
  final List<double> eachSectionPosition;
  final int scrollIndexPositionAt;

  const SliverSectionScrollStateModel({
    required this.categories,
    required this.globalKeys,
    this.sliverTitles = const [],
    this.eachSectionPosition = const [],
    this.scrollIndexPositionAt = 0,
  });

  factory SliverSectionScrollStateModel.idle() => const SliverSectionScrollStateModel(
        categories: <SliverCategoryModel>[],
        globalKeys: <GlobalKey>[],
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SliverSectionScrollStateModel &&
          runtimeType == other.runtimeType &&
          categories == other.categories &&
          globalKeys == other.globalKeys &&
          sliverTitles == other.sliverTitles &&
          eachSectionPosition == other.eachSectionPosition &&
          scrollIndexPositionAt == other.scrollIndexPositionAt);

  @override
  int get hashCode =>
      categories.hashCode ^
      globalKeys.hashCode ^
      sliverTitles.hashCode ^
      eachSectionPosition.hashCode ^
      scrollIndexPositionAt.hashCode;

  @override
  String toString() {
    return 'SliverSectionScrollStateModel{'
        ' categories: $categories,'
        ' globalKeys: $globalKeys,'
        ' sliverTitles: $sliverTitles,'
        ' eachSectionPosition: $eachSectionPosition,'
        ' scrollIndexPositionAt: $scrollIndexPositionAt,'
        '}';
  }

  SliverSectionScrollStateModel copyWith({
    List<SliverCategoryModel>? categories,
    List<GlobalKey>? globalKeys,
    List<GlobalKey>? sliverGlobalKeys,
    List<String>? sliverTitles,
    List<double>? eachSectionPosition,
    int? scrollIndexPositionAt,
  }) {
    return SliverSectionScrollStateModel(
      categories: categories ?? this.categories,
      globalKeys: globalKeys ?? this.globalKeys,
      sliverTitles: sliverTitles ?? this.sliverTitles,
      eachSectionPosition: eachSectionPosition ?? this.eachSectionPosition,
      scrollIndexPositionAt: scrollIndexPositionAt ?? this.scrollIndexPositionAt,
    );
  }
}
