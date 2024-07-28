import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_animations_2/flutter_riverpod/riverpod_functions/riverpod_number_trivia_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'riverpod_function_state.g.dart';

// remember to put ref inside function
// "TriviaRef" is the name of function with adding Ref at the end
@riverpod
Future<RiverpodNumberTriviaModel> trivia(TriviaRef ref) async {
  final headers = {'Content-Type': 'application/json'};
  final response = await http.get(
    Uri.parse("http://numbersapi.com/random?json"),
    headers: headers,
  );
  return RiverpodNumberTriviaModel.fromJson(jsonDecode(response.body));
}
