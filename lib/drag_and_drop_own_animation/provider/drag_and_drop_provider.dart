import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_animations_2/drag_and_drop_own_animation/models/dad_animation_model.dart';

class DragAndDropProvider with ChangeNotifier {
  final List<DADAnimationModel> _items = [
    ...dadAnimationModels,
  ];
  final List<DADAnimationModel> _dadList = [];

  UnmodifiableListView<DADAnimationModel> get dadList =>
      UnmodifiableListView(_dadList);
  UnmodifiableListView<DADAnimationModel> get items =>
      UnmodifiableListView(_items);

  void addToList(DADAnimationModel model) {
    _items.remove(model);
    _dadList.add(model);
    notifyListeners();
  }

  void resetList() {
    _items.clear();
    _dadList.clear();
    _items.addAll(dadAnimationModels);
    notifyListeners();
  }
}
