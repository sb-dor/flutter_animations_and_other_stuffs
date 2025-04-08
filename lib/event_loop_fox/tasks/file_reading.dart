import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter_animations_2/event_loop_fox/contants/isoate_string_constants.dart';


class FileReader {
  void invoke() async {
    final createdIsolatePort = Completer<SendPort>();

    final mainIsolatePort = ReceivePort();

    await Isolate.spawn(_isolate, mainIsolatePort.sendPort);

    late StreamSubscription subs;
    subs = mainIsolatePort.listen((data) {
      if (data is SendPort && !createdIsolatePort.isCompleted) {
        createdIsolatePort.complete(data);
      }
      if (data is String) {
        if (data == StringConstants.createdIsolateIsClosing) {
          mainIsolatePort.close();
          subs.cancel();
        } else {
          print("data coming from createdIsolate: $data");
        }
      }
    });

    final completedCreatedIsolatePort = await createdIsolatePort.future;

    completedCreatedIsolatePort.send(await file());
  }

  Future<File> file() async {
    final tempPath =  Directory.current;
    final file = File('$tempPath/large_file.txt');
    final sink = file.openWrite();
    for (int i = 1; i <= 1000000; i++) {
      sink.writeln('This is line number $i');
    }

    await sink.flush();
    await sink.close();
    await file.create();
    return file;
  }

  static void _isolate(SendPort mainIsolatePort) {
    final createdIsolatePort = ReceivePort();
    mainIsolatePort.send(createdIsolatePort.sendPort);

    createdIsolatePort.listen((data) async {
      if (data is File) {
        mainIsolatePort.send("file length is: ${await data.length()}");
        await data.delete();
        mainIsolatePort.send(StringConstants.createdIsolateIsClosing);
        Isolate.current.kill();
      }
    });
  }
}

void main() {
  final fileReader = FileReader();
  fileReader.invoke();
}
