import 'dart:async';
import 'dart:isolate';

import 'package:flutter_animations_2/event_loop_fox/contants/isoate_string_constants.dart';

class PrimeNumberFinder {
  void invoke() async {
    final isolatePortCompleter = Completer<SendPort>();

    final mainPort = ReceivePort();

    await Isolate.spawn(_isolate, mainPort.sendPort);

    late final StreamSubscription subs;

    subs = mainPort.listen((data) {
      if (data is SendPort && !isolatePortCompleter.isCompleted) {
        isolatePortCompleter.complete(data);
      }

      if (data is String) {
        if (data == StringConstants.createdIsolateIsClosing) {
          mainPort.close();
          subs.cancel();
        } else {
          print(data);
        }
      }
    });

    final isolatePort = await isolatePortCompleter.future;

    isolatePort.send(743);
  }

  static void _isolate(SendPort mainPort) async {
    final isolatePort = ReceivePort();
    mainPort.send(isolatePort.sendPort);

    isolatePort.listen((data) {
      if (data is num) {
        if (data <= 1) {
          mainPort.send("It's not prime number");
          mainPort.send(StringConstants.createdIsolateIsClosing);
          Isolate.current.kill();
        }

        for (int i = 2; i <= data / 2; i++) {
          if (data % i == 0) {
            mainPort.send("It's not prime number");
            mainPort.send(StringConstants.createdIsolateIsClosing);
            Isolate.current.kill();
          }
        }

        mainPort.send("$data is a prime number");
        mainPort.send(StringConstants.createdIsolateIsClosing);
        Isolate.current.kill();
      }
    });
  }
}

void main() {
  final primeNumberFinder = PrimeNumberFinder();
  primeNumberFinder.invoke();
}
