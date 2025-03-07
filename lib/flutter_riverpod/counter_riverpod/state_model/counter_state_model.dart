class CounterStateModel {
  int counter;
  bool changeColor;

  CounterStateModel({this.counter = 0, this.changeColor = false});

  CounterStateModel clone() =>
      CounterStateModel(counter: counter, changeColor: changeColor);
}
