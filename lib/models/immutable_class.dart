import 'package:flutter/material.dart';

//immutable means that, you can not change the object, ones object created - object can not be changed
@immutable
class ImmutableClass {
  const ImmutableClass({required this.id, required this.name});

  final int id;
  final String name;
}
