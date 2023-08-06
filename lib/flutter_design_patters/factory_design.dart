import 'package:flutter/cupertino.dart';

abstract class ApplicationType {
  void saveInvoice();

  factory ApplicationType(String type) {
    switch (type) {
      case "TeaHouse":
        return TeaHouseType();
      case "RestaurantType":
        return RestaurantType();
      default:
        return RestaurantType();
    }
  }
}

class TeaHouseType implements ApplicationType {
  @override
  void saveInvoice() {
    //code that save teaHouse invoice
    debugPrint("tea house saver");
  }
}

class RestaurantType implements ApplicationType {
  @override
  void saveInvoice() {
    debugPrint("restaurant saver");
  }
}
