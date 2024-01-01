import 'dart:isolate';

import 'package:flutter/cupertino.dart';

abstract class DartIsoExample1 {
  static void runIsolate() async {
    await for (var each in getMessages().take(10)) {
      debugPrint("each time: $each");
    }
  }

  static Stream<String> getMessages() {
    final rp = ReceivePort();

    return Isolate.spawn(_getMessages, rp.sendPort)
        .asStream()
        .asyncExpand((event) => rp)
        .takeWhile((el) => el is String)
        .cast(); // cast will automatically understand that what should it return looking to the function "return"
  }

  static void _getMessages(SendPort sp) async {
    await for (var now
        in Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now().toIso8601String())) {
      sp.send(now);
    }
  }
}
