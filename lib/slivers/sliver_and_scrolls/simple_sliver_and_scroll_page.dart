import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

final class _ProductsWithCategory {
  final String category;
  final List<String> products;

  _ProductsWithCategory({
    required this.category,
    required this.products,
  });
}

class SimpleSliverAndScrollPage extends StatefulWidget {
  const SimpleSliverAndScrollPage({super.key});

  @override
  State<SimpleSliverAndScrollPage> createState() => _SimpleSliverAndScrollPageState();
}

class _SimpleSliverAndScrollPageState extends State<SimpleSliverAndScrollPage> {
  int currentSliverHeaderPosition = 0;

  List<_ProductsWithCategory> sliverForHeaders = [];

  List<String> categoriesHeader = [];

  @override
  void initState() {
    super.initState();
    categoriesHeader = [
      "Fruits",
      "Meals",
      "Vegetables",
      "Pizzas",
    ];
    sliverForHeaders = [
      _ProductsWithCategory(
        category: "Fruits",
        products: ["Bananas", "Apples", "Watermelons", "Melons", "Grapes"]..shuffle(),
      ),
      _ProductsWithCategory(
        category: "Meals",
        products: ["Bananas", "Apples", "Watermelons", "Melons", "Grapes"]..shuffle(),
      ),
      _ProductsWithCategory(
        category: "Vegetables",
        products: ["Bananas", "Apples", "Watermelons", "Melons", "Grapes"]..shuffle(),
      ),
      _ProductsWithCategory(
        category: "Pizzas",
        products: ["Bananas", "Apples", "Watermelons", "Melons", "Grapes"]..shuffle(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "Simple sliver and scroll",
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              sliver: SliverPersistentHeader(
                pinned: true,
                delegate: SliverHeaderDelegate(
                  categoriesHeader,
                  currentSliverHeaderPosition,
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            for (int i = 0; i < sliverForHeaders.length; i++) ...[
              SliverPadding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                sliver: SliverPersistentHeader(
                  delegate: SliverForHeaderDelegate(
                    prodWithCateg: sliverForHeaders[i],
                    onScroll: (value) {
                      Future.microtask(() {
                        if (value) {
                          currentSliverHeaderPosition = i;
                          setState(() {});
                        }
                      });
                    },
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = sliverForHeaders[index];
                    return ListTile(
                      title: Text(item.category),
                    );
                  },
                  childCount: sliverForHeaders.length,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

class SliverForHeaderDelegate extends SliverPersistentHeaderDelegate {
  final _ProductsWithCategory prodWithCateg;
  final ValueChanged<bool> onScroll;

  SliverForHeaderDelegate({
    required this.prodWithCateg,
    required this.onScroll,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    if (shrinkOffset > 0) {
      onScroll(true);
    } else {
      onScroll(false);
    }
    return Container(
      child: Text(
        "Title: ${prodWithCateg.category}",
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 30;

  @override
  // TODO: implement minExtent
  double get minExtent => 30;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final List<String> categoriesHeader;
  final int currentIndex;

  SliverHeaderDelegate(
    this.categoriesHeader,
    this.currentIndex,
  );

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 50,
      color: Colors.white,
      child: ScrollablePositionedList.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categoriesHeader.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: currentIndex == index ? Colors.amber : null,
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Center(
              child: Text(categoriesHeader[index]),
            ),
          );
        },
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 50;

  @override
  // TODO: implement minExtent
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
