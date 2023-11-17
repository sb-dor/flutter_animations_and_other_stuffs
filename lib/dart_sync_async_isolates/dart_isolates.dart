import 'dart:isolate';

import 'package:flutter/cupertino.dart';

class DartIsolates {
  static void runIsolate() async {
    debugPrint(
        "you have a lot of code here but you want to start some another code sync with this code");

    // создаем порт приема сообщений от нового изолята
    final receivePort = ReceivePort();

    // создаем новый изолят
    final isolate = await Isolate.spawn(anotherFunctionThatWillWorkInIsolate, receivePort.sendPort);

    // запускаем прослушивание входящих сообщений
    receivePort.listen((message) {
      debugPrint(message);
      // изолят больше не нужен  - завершаем его
      receivePort.close();
      isolate.kill();
    });

    debugPrint("here will be another code");
    await Future.delayed(const Duration(seconds: 10));
    debugPrint("working isolate 1");
  }

  static void anotherFunctionThatWillWorkInIsolate(SendPort sendPort) async {
    await Future.delayed(const Duration(seconds: 10));
    sendPort.send("working isolate 2");
  }
}
