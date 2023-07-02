import 'package:flutter_animations_2/models/cars/helpers/cars_function.dart';
import 'package:flutter_animations_2/models/cars/helpers/transmission.dart';

class Bmw implements CarsFunction {
  @override
  Transmission? transmission;

  Bmw({required this.transmission});

  @override
  void drive() {
    // TODO: implement drive
  }

  @override
  void speed() {
    print("i show speed");
  }
}
