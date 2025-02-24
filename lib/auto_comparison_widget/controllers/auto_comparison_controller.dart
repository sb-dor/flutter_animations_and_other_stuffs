import 'package:flutter/material.dart';
import 'package:flutter_animations_2/auto_comparison_widget/widgets/animted_comparison_tombar.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

final class AutoComparisonController with ChangeNotifier {
  //
  AutoComparisonController({
    required LinkedScrollControllerGroup scrollControllerGroup,
    required PageController pageController,
  })  : _scrollControllerGroup = scrollControllerGroup,
        _pageController = pageController {
    _scrollControllerGroup.addOffsetChangedListener(_scrollListener);
    _pageController.addListener(_pageViewListener);
  }

  final LinkedScrollControllerGroup _scrollControllerGroup;
  final PageController _pageController;

  bool startedToScrollPageView = false, showAnimatedTopBar = false;
  double scrollingTextOffset = 0.0;

  void _scrollListener() {
    if (!startedToScrollPageView) {
      scrollingTextOffset = _scrollControllerGroup.offset;
      notifyListeners();
    }
    if (!showAnimatedTopBar && _scrollControllerGroup.offset >= animatedTopBarHeight) {
      showAnimatedTopBar = true;
      notifyListeners();
    } else if (showAnimatedTopBar && _scrollControllerGroup.offset < animatedTopBarHeight) {
      showAnimatedTopBar = false;
      notifyListeners();
    }
  }

  void _pageViewListener() {
    final double normalizedPage = _pageController.page! % 1.0;
    if (normalizedPage > 0.0 && !startedToScrollPageView) {
      startedToScrollPageView = true;
      notifyListeners();
    } else if (normalizedPage <= 0.0 && startedToScrollPageView) {
      startedToScrollPageView = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _scrollControllerGroup.removeOffsetChangedListener(_scrollListener);
    _pageController.removeListener(_pageViewListener);
    super.dispose();
  }
}
