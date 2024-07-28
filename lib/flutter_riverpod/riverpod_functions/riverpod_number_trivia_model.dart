import 'package:flutter/material.dart';

@immutable
class RiverpodNumberTriviaModel {
  final String? text;
  final int? number;

  const RiverpodNumberTriviaModel(this.text, this.number);

  factory RiverpodNumberTriviaModel.fromJson(Map<String, dynamic> json) {
    return RiverpodNumberTriviaModel(
      json['text'],
      int.tryParse("${json['number']}"),
    );
  }
}
