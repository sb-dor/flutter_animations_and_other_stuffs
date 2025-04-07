import 'dart:async';
import 'dart:isolate';

import 'package:flutter_animations_2/event_loop_fox/contants/isoate_string_constants.dart';

class ListSortIsolate {
  final List<int> _unsortedIntList = [
    1,
    6,
    8,
    1,
    3,
    44,
    31,
    43,
    33,
    556,
    14,
    6,
    7,
    1234,
    6,
    12,
    5756,
    323,
    21,
    57,
    8,
    9,
  ];

  void invoke() async {
    final newIsolatePortCompleter = Completer<SendPort>();

    final mainIsolateReceivePort = ReceivePort();
    final newIsolate = await Isolate.spawn(_isolate, mainIsolateReceivePort.sendPort);

    late final StreamSubscription mainIsolateSubs;
    mainIsolateSubs = mainIsolateReceivePort.listen((data) {
      if (data is SendPort && !newIsolatePortCompleter.isCompleted) {
        newIsolatePortCompleter.complete(data);
      }

      if (data is String && data == StringConstants.createdIsolateIsClosing) {
        mainIsolateSubs.cancel();
        mainIsolateReceivePort.close();
      }

      if (data is List) {
        print("sorted list is: $data");
      }
    });

    final SendPort newIsolatePort = await newIsolatePortCompleter.future;

    newIsolatePort.send(_unsortedIntList);
  }

  static _isolate(SendPort mainIsolatePort) {
    final ReceivePort newIsolatePort = ReceivePort();
    mainIsolatePort.send(newIsolatePort.sendPort);

    newIsolatePort.listen((data) {
      if (data is List<int>) {
        int test = 0;
        for (int i = 0; i < data.length - 1; i++) {
          if (data[i] > data[i + 1]) {
            final tempNum = data[i];
            data[i] = data[i + 1];
            data[i + 1] = tempNum;
            i = 0;
            test++;
          }
        }
        print("object: $test");
        mainIsolatePort.send(data);
        mainIsolatePort.send(StringConstants.createdIsolateIsClosing);
        Isolate.current.kill();
      }
    });
  }
}

void main() async {
  final listSortIsolate = ListSortIsolate();
  listSortIsolate.invoke();
}
