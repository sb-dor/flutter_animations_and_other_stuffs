abstract class CalcService {
  int plus();

  int minus();
}

class FirstCalc implements CalcService {
  @override
  int minus() {
    // TODO: implement minus
    throw UnimplementedError();
  }

  @override
  int plus() {
    // TODO: implement plus
    throw UnimplementedError();
  }
}

class SecondCalc implements CalcService {
  @override
  int minus() {
    // TODO: implement minus
    throw UnimplementedError();
  }

  @override
  int plus() {
    // TODO: implement plus
    throw UnimplementedError();
  }
}
