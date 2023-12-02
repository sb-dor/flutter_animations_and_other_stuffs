import 'dart:async';

//data for changing
class SimpleStreamBlocData {
  int counter;

  SimpleStreamBlocData({this.counter = 0});
}

class SimpleStreamBloc {
  //data for changing
  late SimpleStreamBlocData simpleStreamBlocData;

  //make your bloc singleton
  static SimpleStreamBloc? _instance;

  static SimpleStreamBloc get instance => _instance ??= SimpleStreamBloc._();

  SimpleStreamBloc._();

  //

  //then create controller which will change data
  final StreamController<SimpleStreamBlocData> _blocController =
      StreamController<SimpleStreamBlocData>.broadcast();

  //subscribe to the controller's stream to change UI
  Stream<SimpleStreamBlocData> get streamListener => _blocController.stream;

  //init controller data at first
  void initData() {
    simpleStreamBlocData = SimpleStreamBlocData();
    _updateState(simpleStreamBlocData);
  }

  //simple functions
  void increment() async {
    simpleStreamBlocData.counter++;
    _updateState(simpleStreamBlocData);
  }

  //and remember that nobody should update state out of this class or library
  //cause it's a private function that updates state
  void _updateState(SimpleStreamBlocData simpleStreamBlocData) {
    _blocController.sink.add(simpleStreamBlocData);
  }
}
