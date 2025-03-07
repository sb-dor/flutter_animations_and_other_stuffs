// for more info:
// https://github.com/hawkkiller/sizzle_starter/blob/main/packages/rest_client/lib/src/rest_client_base.dart

import 'dart:convert';

import 'package:flutter/foundation.dart';

sealed class ResponseParser<T> {
  //
  ResponseParser({required this.body});

  T? body;
}

final class StringResponseParser extends ResponseParser<String> {
  StringResponseParser({required super.body});
}

final class BytesResponseParser extends ResponseParser<List<int>> {
  BytesResponseParser({required super.body});
}

final class MapResponseParser extends ResponseParser<Map<String, dynamic>> {
  MapResponseParser({required super.body});
}

final class ResponseParserHelper {
  final _jsonUTF8 = json.fuse(utf8);

  Future<Map<String, dynamic>?> decodeResponse({
    ResponseParser<Object?>? data,
    int? statusCode,
  }) async {
    try {
      final decodedResponse = switch (data) {
        StringResponseParser(body: final String data) =>
          await _decodeString(data),
        BytesResponseParser(body: final List<int> data) =>
          await _decodeBytes(data),
        MapResponseParser(body: final Map<String, dynamic> data) => data,
        _ => <String, dynamic>{},
      };

      if (decodedResponse case {"error": Map<String, dynamic> error}) {
        // return error here
      }

      if (decodedResponse case {"data": Map<String, dynamic> data}) {
        // return data
      }

      return decodedResponse;
    } catch (error, stackTrace) {
      // you handler
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<Map<String, dynamic>?> _decodeString(String data) async {
    if (data.isEmpty) return null;

    if (data.length > 1000) {
      return (await compute(jsonDecode, data)) as Map<String, dynamic>?;
    }

    return jsonDecode(data) as Map<String, dynamic>?;
  }

  Future<Map<String, dynamic>?> _decodeBytes(List<int> data) async {
    if (data.isEmpty) return null;

    if (data.length > 1000) {
      return (await compute(_jsonUTF8.decode, data)) as Map<String, dynamic>?;
    }

    return _jsonUTF8.decode(data) as Map<String, dynamic>?;
  }
}
