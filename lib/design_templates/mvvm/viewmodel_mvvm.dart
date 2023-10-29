import 'package:flutter/material.dart';
import 'package:flutter_animations_2/design_templates/mvvm/model_mvvm.dart';

class ViewModelMVVM extends ChangeNotifier {
  ModelMVVM modelMVVM = ModelMVVM();

  void increment() {
    modelMVVM.counter++;
    notifyListeners();
  }
}
