import 'package:flutter/material.dart';

class DADAnimationModel with ChangeNotifier {
  String? firstName;
  String? lastName;
  String? asset;
  double? money;

  Offset? imagePosition;
  Offset? fNamePosition;

  DADAnimationModel({
    this.firstName,
    this.lastName,
    this.asset,
    this.money,
  });

  void initDADAnimationOffsets({
    required Offset? imagePosition,
    required Offset? fNamePosition,
  }) {
    this.imagePosition = imagePosition;
    this.fNamePosition = fNamePosition;
  }
}

final dadAnimationModels = [
  DADAnimationModel(
    firstName: "Ian",
    lastName: "Hickson",
    asset: 'drag_and_drop_animation_assets/ian_hickson.png',
    money: 60,
  ),
  DADAnimationModel(
    firstName: "Eric",
    lastName: "Seidel",
    asset: 'drag_and_drop_animation_assets/eric_seidel.jpg',
    money: 50,
  ),
  DADAnimationModel(
    firstName: "Adam",
    lastName: "Barth",
    asset: 'drag_and_drop_animation_assets/adam_barth.jpg',
    money: 60,
  ),
  DADAnimationModel(
    firstName: "Filip",
    lastName: "Hráček",
    asset: 'drag_and_drop_animation_assets/filip_hracek.jpg',
    money: 40,
  ),
];
