import 'package:flutter/material.dart';

@immutable
class RiverpodNumberTrivia {
  final String? text;
  final int? number;

  const RiverpodNumberTrivia(this.text, this.number);

  factory RiverpodNumberTrivia.fromJson(Map<String, dynamic> json) {
    return RiverpodNumberTrivia(
      json['text'],
      int.tryParse("${json['number']}"),
    );
  }
}
