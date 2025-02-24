import 'package:flutter/material.dart';

final class AutoComparisonTopBarController with ChangeNotifier {
  AutoComparisonTopBarController({
    required final PageController pageController,
  }) : _pageController = pageController {
    _pageController.addListener(_listener);
  }

  final PageController _pageController;
  double pageOffset = 0.0;

  void _listener() {
    pageOffset = _pageController.page ?? 0.0;
    notifyListeners();
  }

  @override
  void dispose() {
    debugPrint("disposing controller: ${toString()}");
    _pageController.removeListener(_listener);
    super.dispose();
  }
}
