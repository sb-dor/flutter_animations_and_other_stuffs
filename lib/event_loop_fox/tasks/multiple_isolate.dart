import 'dart:async';
import 'dart:isolate';

import 'package:flutter_animations_2/event_loop_fox/contants/isoate_string_constants.dart';

class IsolateCreator {
  // numberOfIsolate is for test
  Future<SendPort> create(int numberOfIsolate) async {
    final newIsolateSendPort = Completer<SendPort>();

    final mainPort = ReceivePort();

    await Isolate.spawn(_isolate, mainPort.sendPort);

    late final StreamSubscription subs;

    subs = mainPort.listen((data) {
      if (data is SendPort && !newIsolateSendPort.isCompleted) {
        newIsolateSendPort.complete(data);
      }
      if (data is String) {
        if (data == StringConstants.createdIsolateIsClosing) {
          mainPort.close();
          subs.cancel();
          print("isolate $numberOfIsolate is killed");
        } else {
          print("coming data from isolate $numberOfIsolate: $data");
        }
      }
    });

    return newIsolateSendPort.future;
  }

  static void _isolate(SendPort mainPort) async {
    final isolatePort = ReceivePort();
    mainPort.send(isolatePort.sendPort);

    isolatePort.listen((data) {
      if (data is num) {
        if (data <= 1) {
          mainPort.send("Prime numbers not found ");
          mainPort.send(StringConstants.createdIsolateIsClosing);
          Isolate.current.kill();
        }

        int primeNumbers = 0;
        for (int number = 2; number < data; number++) {
          bool found = true;
          for (int i = 2; i <= number / 2; i++) {
            if (number % i == 0) {
              found = false;
              break;
            }
          }
          if (found) primeNumbers++;
        }

        mainPort.send("prime numbers found: $primeNumbers");
        mainPort.send(StringConstants.createdIsolateIsClosing);
        Isolate.current.kill();
      }
    });
  }
}

void main() async {
  final isolateCreator = IsolateCreator();

  final firstIsolateSendPort = await isolateCreator.create(1);
  final secondIsolateSendPort = await isolateCreator.create(2);

  firstIsolateSendPort.send(700000);
  secondIsolateSendPort.send(70000);
}
