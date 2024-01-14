import 'package:faker/faker.dart';
import 'package:flutter_animations_2/functions/randoms.dart';

class YtFlLocModel {
  String? imageUrl;
  String? address;
  String? location;
  bool isOpen;

  YtFlLocModel({
    this.imageUrl,
    this.address,
    this.location,
    this.isOpen = false,
  });
}
