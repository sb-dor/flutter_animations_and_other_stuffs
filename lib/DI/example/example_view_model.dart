import 'calc_service.dart';

abstract class ExampleViewModel {
  void onPressMe1();

  void onPressMe2();
}

class ExampleCalcModel implements ExampleViewModel {
  final CalcService _calcService;

  ExampleCalcModel(this._calcService);

  @override
  void onPressMe1() {
    print(1 + 3);
  }

  @override
  void onPressMe2() {
    print(4);
  }
}

class ExamplePetModel implements ExampleViewModel {
  @override
  void onPressMe1() {
    print("barking");
  }

  @override
  void onPressMe2() {
    print("miyayu miyayu");
  }
}
