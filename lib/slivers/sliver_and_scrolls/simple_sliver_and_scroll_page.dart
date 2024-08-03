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
  bool hasPermissionForScroll = false;

  int currentSliverHeaderPosition = 0;

  List<_ProductsWithCategory> sliverForHeaders = [];

  List<String> categoriesHeader = [];

  ItemScrollController itemScrollController = ItemScrollController();

  ItemScrollController secondItemScrollController = ItemScrollController();

  @override
  void initState() {
    super.initState();
    categoriesHeader = [
      "Fruits",
      "Meals",
      "Vegetables",
      "Pizzas",
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

    Future.delayed(const Duration(milliseconds: 300), () {
      hasPermissionForScroll = true;
      setState(() {});
    });
  }

  void setPosition(bool value, int index) {
    if (value) {
      currentSliverHeaderPosition = index;
    } else {
      currentSliverHeaderPosition =
          currentSliverHeaderPosition == index ? currentSliverHeaderPosition - 1 : index;
    }
    if (currentSliverHeaderPosition <= 0 ||
        currentSliverHeaderPosition >= sliverForHeaders.length) {
      currentSliverHeaderPosition = 0;
    }
    setState(() {});
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
                  itemScrollController,
                  secondItemScrollController,
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
                    itemScrollController: itemScrollController,
                    // index: i,
                    onScroll: (value) {
                      debugPrint("scrolling index: $i | permission: $value");
                      Future.microtask(() {
                        setPosition(value, i);
                        if (hasPermissionForScroll) {
                          itemScrollController.scrollTo(
                            index: currentSliverHeaderPosition,
                            duration: const Duration(
                              milliseconds: 500,
                            ),
                            curve: Curves.bounceInOut,
                          );
                        }
                        setState(() {});
                      });
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: ScrollablePositionedList.separated(
                  // itemScrollController: secondItemScrollController,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: sliverForHeaders.length,
                  itemBuilder: (context, index) {
                    final item = sliverForHeaders[index];
                    return ListTile(
                      title: Text(item.category),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                ),
              )
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
  final ItemScrollController itemScrollController;

  // final int index;

  SliverForHeaderDelegate({
    required this.prodWithCateg,
    required this.onScroll,
    required this.itemScrollController,
    // required this.index,
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
          fontSize: 20,
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
  final ItemScrollController itemScrollController;
  final ItemScrollController listItemScrollController;

  SliverHeaderDelegate(
    this.categoriesHeader,
    this.currentIndex,
    this.itemScrollController,
    this.listItemScrollController,
  );

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 50,
      color: Colors.white,
      child: ScrollablePositionedList.separated(
        itemScrollController: itemScrollController,
        scrollDirection: Axis.horizontal,
        itemCount: categoriesHeader.length,
        separatorBuilder: (context, index) => const SizedBox(width: 20),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              listItemScrollController.scrollTo(
                index: index,
                duration: const Duration(milliseconds: 500),
              );
            },
            child: Container(
              padding: const EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                color: currentIndex == index ? Colors.amber : Colors.transparent,
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Center(
                child: Text(categoriesHeader[index]),
              ),
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
