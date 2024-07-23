import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class DADAnimationModel {
  String? firstName;
  String? lastName;
  String? asset;
  double? money;

  Offset? position;
  Offset? fNamePosition;
  Offset? lNamePosition;
  Offset? imageOffSet;
  Offset? moneyOffSet;

  DADAnimationModel({
    this.firstName,
    this.lastName,
    this.asset,
    this.money,
  });

  void initDADAnimationOffsets({
    required Offset? position,
    required Offset? fNamePosition,
    required Offset? lNamePosition,
    required Offset? imageOffSet,
    required Offset? moneyOffSet,
  }) {
    this.position = position;
    this.fNamePosition = fNamePosition;
    this.lNamePosition = lNamePosition;
    this.imageOffSet = imageOffSet;
    this.moneyOffSet = moneyOffSet;
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
