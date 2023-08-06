import 'package:flutter_animations_2/flutter_design_patters/factory_design.dart';

//the main reason of abstract factory design is creating factory of factories
abstract class AbstractFactory {
  void saveInvoice(String type);
}

class AbstractFactoryImp implements AbstractFactory {
  @override
  void saveInvoice(String type) {
    ApplicationType(type).saveInvoice();
  }
}
