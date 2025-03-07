import 'dart:isolate';

import 'package:flutter/cupertino.dart';

class DartIsolates {
  static void runIsolate() async {
    debugPrint(
        "you have a lot of code here but you want to start some another code sync with this code");

    // создаем порт приема сообщений от нового изолята
    final receivePort = ReceivePort();

    // создаем новый изолят
    final isolate = await Isolate.spawn(
        anotherFunctionThatWillWorkInIsolate, receivePort.sendPort);

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

  static void runIsolate2() async {
    final receiverPort = ReceivePort();
    final receiverPort2 = ReceivePort();
    debugPrint("start run isolate 2");

    // to run code in two isolates create two different receivePort
    // other way it will throw an exception
    final isolate1 =
        await Isolate.spawn(isolate2FirstFunc, receiverPort.sendPort);
    final isolate2 =
        await Isolate.spawn(isolate2FSecondFunc, receiverPort2.sendPort);

    receiverPort.listen((message) {
      debugPrint("$message");
      receiverPort.close();
      isolate1.kill();
    });

    receiverPort2.listen((message) {
      debugPrint("$message");
      receiverPort2.close();
      isolate2.kill();
    });
  }

  static void isolate2FirstFunc(SendPort sendPort) {
    for (int i = 0; i < 4000000000; i++) {}
    sendPort.send('first iterable finished');
  }

  static void isolate2FSecondFunc(SendPort sendPort) {
    for (int i = 0; i < 4000000000; i++) {}
    sendPort.send("second iterable finished");
  }
}
