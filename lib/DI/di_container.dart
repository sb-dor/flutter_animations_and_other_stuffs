// DI container
import 'package:flutter/material.dart';
import 'package:flutter_animations_2/DI/calc_service.dart';
import 'package:flutter_animations_2/DI/di_page.dart';
import 'package:flutter_animations_2/DI/example_view_model.dart';

class DIContainer {
  CalcService _calcService() => FirstCalc();

  ExampleViewModel _exampleCalcModel() => ExampleCalcModel(_calcService());

  Widget exampleWidget() => DiPage(model: _exampleCalcModel());
}
