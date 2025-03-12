part of 'surf_catalog_screen.dart';

final class _SurfSyncScrollController with ChangeNotifier {
  // Indent offset for vertical list
  static const double _scrollStickyOffset = 112;

  _SurfSyncScrollController() {
    // Add a listener to calculate the visibility of the category
    // when scrolling the vertical list
    verticalScrollController.addListener(_calculateCategoryVisible);
    _randomizeCategories();
  }

  // Randomization of categories with products
  void _randomizeCategories() {
    final Random random = Random();
    categories = List.generate(
      random.nextInt(10),
      (int categoryIndex) => SurfCategory(
        id: categoryIndex.toString(),
        title: 'Category $categoryIndex',
        products: List.generate(
          random.nextInt(20),
          (int productIndex) => SurfProduct(
            id: productIndex.toString(),
            title: 'Category $categoryIndex\nProduct $productIndex',
            isLargeCard: random.nextBool(),
          ),
        ),
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners());
  }

  // List of categories with products
  List<SurfCategory> categories = [];

  // Current selected category index
  int categoryIndex = 0;

  // Flag to ignore scrolling if the desired category is selected
  bool _isIgnoreCatalogScroll = false;

  // AutoScroll-controllers of horizontal and vertical lists
  final AutoScrollController horizontalScrollController = AutoScrollController(
    axis: Axis.horizontal,
  );
  final AutoScrollController verticalScrollController = AutoScrollController(axis: Axis.vertical);

  // Calculate the desired scroll position to the desired index of a specific AutoScroll controller
  // not tied to a specific controller
  double? _getCategoryOffset(int index, AutoScrollController controller) {
    // Get widget context by index from AutoScroll controller
    // This context was saved at build time and allows to find widget rendering area
    final BuildContext? context = controller.tagMap[index]?.context;
    if (context == null) {
      return null;
    }
    // Find the widget's rendering object
    final RenderObject? renderBox = context.findRenderObject();
    if (renderBox == null) {
      return null;
    }
    // From the received render area we get the port and calculate the offset from the beginning of the scroll
    final RenderAbstractViewport viewport = RenderAbstractViewport.of(renderBox);
    final RevealedOffset revealedOffset = viewport.getOffsetToReveal(renderBox, 0);
    // With this calculation, the getOffsetToReveal function can return a RevealedOffset object
    // with a double.infinity offset.
    // This means that it was not possible to calculate the offset from the beginning of the scroll, let's say, there is no such widget
    // in the hierarchy of widgets inside the scroll
    if (revealedOffset.offset == double.infinity) {
      return null;
    }

    return revealedOffset.offset;
  }

  // Calculate the visibility of a specific category when scrolling a vertical list
  void _calculateCategoryVisible() {
    // When you click on a category in the horizontal scroll (which shows all of the available categories),
    // it should scroll to a specific offset. That’s why, during this scrolling,
    // the current offset calculation is temporarily disabled until the scroll finishes.
    if (_isIgnoreCatalogScroll) {
      return;
    }

    int newIndex = 0;
    // Loop through all indexes of the vertical AutoScroll controller
    for (final int index in verticalScrollController.tagMap.keys) {
      // Find the vertical offset to the index of the function that was prepared in advance
      final double? offset = _getCategoryOffset(index, verticalScrollController);
      if (offset == null) {
        continue;
      }
      // If the vertical controller has not yet reached a larger offset value
      // Then the other category is not yet in the visibility zone
      if (offset >= verticalScrollController.offset + _scrollStickyOffset) {
        continue;
      }
      newIndex = index;
    }
    if (categoryIndex == newIndex) {
      return;
    }

    categoryIndex = newIndex;
    notifyListeners();
    _scrollToHorizontalCategory(newIndex);
  }

  // Scroll to the desired horizontal category
  // Needed in several places - when scrolling a vertical list
  // and when selecting another category
  Future<void> _scrollToHorizontalCategory(int index) async {
    if (index == 0) {
      return horizontalScrollController.animateTo(
        0,
        duration: scrollAnimationDuration,
        curve: Curves.easeInOut,
      );
    }
    return horizontalScrollController.scrollToIndex(index);
  }

  // Refresh and randomization of new categories with products
  Future<void> onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    categoryIndex = 0;
    _randomizeCategories();
  }

  // Select the desired category
  void onPressedCategory({required int index}) async {
    if (index == categoryIndex) {
      return;
    }

    // So we use the prepared function to get the scroll offset of the vertical list
    final double? offset = _getCategoryOffset(index, verticalScrollController);
    if (offset == null) {
      return;
    }

    // Update the new index
    categoryIndex = index;
    notifyListeners();
    // Move to a new position in the horizontal list
    _scrollToHorizontalCategory(index).ignore();
    // And in the vertical - welded protected by a flag,
    // which is used in the function defining the visibility of the category
    _isIgnoreCatalogScroll = true;
    await verticalScrollController.animateTo(
      offset - _scrollStickyOffset,
      duration: scrollAnimationDuration,
      curve: Curves.easeInOut,
    );
    _isIgnoreCatalogScroll = false;
  }

  // Don't forget to dispose controllers
  @override
  void dispose() {
    horizontalScrollController.dispose();
    verticalScrollController.dispose();
    super.dispose();
  }
}
