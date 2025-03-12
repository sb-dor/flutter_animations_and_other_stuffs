import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animations_2/slivers/surf_sync_scroll/component/surf_chips.dart';
import 'package:flutter_animations_2/slivers/surf_sync_scroll/component/surf_product_card.dart';
import 'package:flutter_animations_2/slivers/surf_sync_scroll/component/surf_story_card.dart';
import 'package:flutter_animations_2/slivers/surf_sync_scroll/models/surf_category.dart';
import 'package:flutter_animations_2/slivers/surf_sync_scroll/models/surf_product.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:sliver_tools/sliver_tools.dart';

part 'surf_sync_scroll_controller.dart';

class SurfCatalogScreen extends StatefulWidget {
  const SurfCatalogScreen({super.key});

  @override
  State<SurfCatalogScreen> createState() => _SurfCatalogScreenState();
}

class _SurfCatalogScreenState extends State<SurfCatalogScreen> {
  late final _SurfSyncScrollController _surfSyncScrollController;

  @override
  void initState() {
    super.initState();
    _surfSyncScrollController = _SurfSyncScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          controller: _surfSyncScrollController.verticalScrollController,
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            const CupertinoSliverNavigationBar(largeTitle: Text('Scroll down')),
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 16),
              sliver: CupertinoSliverRefreshControl(onRefresh: _surfSyncScrollController.onRefresh),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 16),
              sliver: SliverToBoxAdapter(
                child: SizedBox(
                  height: 124,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    separatorBuilder: (context, index) => const SizedBox(width: 8),
                    itemCount: 6,
                    itemBuilder: (context, index) => const SurfStoryCard(),
                  ),
                ),
              ),
            ),
            DecoratedSliver(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                color: Colors.grey[200],
              ),
              sliver: SliverPadding(
                padding: const EdgeInsets.only(top: 16),
                sliver: SliverStickyHeader(
                  overlapsContent: true,
                  header: SizedBox(
                    height: 56,
                    child: ColoredBox(
                      color: Colors.grey[200] ?? Colors.white,
                      child: Center(
                        child: SizedBox(
                          height: 40,
                          child: ListenableBuilder(
                            listenable: _surfSyncScrollController,
                            builder:
                                (BuildContext context, Widget? child) => ListView.separated(
                                  controller: _surfSyncScrollController.horizontalScrollController,
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  separatorBuilder:
                                      (BuildContext context, int index) => const SizedBox(width: 8),
                                  itemCount: _surfSyncScrollController.categories.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final SurfCategory category =
                                        _surfSyncScrollController.categories[index];

                                    return AutoScrollTag(
                                      key: ValueKey(
                                        'Category-$index-${category.id}-${category.title}',
                                      ),
                                      controller:
                                          _surfSyncScrollController.horizontalScrollController,
                                      index: index,
                                      child: SurfChips(
                                        title: category.title,
                                        onPressed:
                                            () => _surfSyncScrollController.onPressedCategory(
                                              index: index,
                                            ),
                                        isSelected:
                                            _surfSyncScrollController.categoryIndex == index,
                                      ),
                                    );
                                  },
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  sliver: SliverPadding(
                    padding: const EdgeInsets.only(top: 64, left: 12, right: 12, bottom: 64),
                    sliver: ListenableBuilder(
                      listenable: _surfSyncScrollController,
                      builder:
                          (BuildContext context, Widget? child) => MultiSliver(
                            children:
                                _surfSyncScrollController.categories
                                    .mapIndexed(
                                      (int index, SurfCategory category) => SliverToBoxAdapter(
                                        child: AutoScrollTag(
                                          key: ValueKey(
                                            'CategoryProduct-$index-${category.id}-${category.title}',
                                          ),
                                          controller:
                                              _surfSyncScrollController.verticalScrollController,
                                          index: index,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                category.title,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: List.generate(category.products.length, (
                                                  int index,
                                                ) {
                                                  final SurfProduct product =
                                                      category.products[index];

                                                  return Padding(
                                                    padding: const EdgeInsets.only(bottom: 8),
                                                    child: SurfProductCard(product: product),
                                                  );
                                                }),
                                              ),
                                              const SizedBox(height: 32),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
