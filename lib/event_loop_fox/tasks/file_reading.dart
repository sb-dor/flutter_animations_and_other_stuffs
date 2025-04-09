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

    final createFileHelper = CreateFileHelper();

    print("mail isolate create file helper hascode: ${createFileHelper.hashCode}");
    print("mail isolate create file helper hascode: ${createFileHelper.hashCode}");
    completedCreatedIsolatePort.send(createFileHelper);
    // ;
  }

  static void _isolate(SendPort mainIsolatePort) {
    final createdIsolatePort = ReceivePort();
    mainIsolatePort.send(createdIsolatePort.sendPort);

    createdIsolatePort.listen((data) async {
      if (data is CreateFileHelper) {
        mainIsolatePort.send("create file helper hashcode: ${data.hashCode}");
        mainIsolatePort.send("file is creating");
        final file = await data.createFile();
        mainIsolatePort.send("file length is: ${await file.length() / (1024 * 1024)} mb"); // to mb
        await file.delete();
        mainIsolatePort.send(StringConstants.createdIsolateIsClosing);
        Isolate.current.kill();
      }
    });
  }
}

class CreateFileHelper {
  Future<File> createFile() async {
    final tempPath = Directory.current;
    final file = File("${tempPath.path}/lib/event_loop_fox/tasks/large_file.txt");
    final sink = file.openWrite();
    for (int i = 1; i <= 1000000; i++) {
      sink.writeln('This is line number $i');
    }

    await sink.flush();
    await sink.close();
    await file.create();
    return file;
  }
}

void main() {
  final fileReader = FileReader();
  fileReader.invoke();
}
