import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:flutter_animations_2/event_loop_fox/contants/isoate_string_constants.dart';

class CompressImageIsolate {
  void invoke() async {
    final createdIsolatePortCompleter = Completer<SendPort>();

    final mainIsolatePort = ReceivePort();

    await Isolate.spawn(_isolate, mainIsolatePort.sendPort);

    late StreamSubscription subs;
    subs = mainIsolatePort.listen((data) {
      if (data is SendPort && !createdIsolatePortCompleter.isCompleted) {
        createdIsolatePortCompleter.complete(data);
      } else if (data is String && data == StringConstants.createdIsolateIsClosing) {
        subs.cancel();
        mainIsolatePort.close();
      }
    });

    final createdIsolateSendPort = await createdIsolatePortCompleter.future;

    final image = File("${Directory.current.path}/lib/event_loop_fox/tasks/img.png");

    createdIsolateSendPort.send(await image.readAsBytes());
  }

  static void _isolate(SendPort mainIsolatePort) async {
    final ReceivePort receivePort = ReceivePort();
    mainIsolatePort.send(receivePort.sendPort);

    receivePort.listen((data) {
      if (data is Uint8List) {
        final original = img.decodeImage(data);
        if (original == null) {
          mainIsolatePort.send(StringConstants.createdIsolateIsClosing);
          Isolate.current.kill();
          return;
        }
        final compressed = img.encodeJpg(original, quality: 70);

        final fileForNewSave = File("${Directory.current.path}/lib/event_loop_fox/tasks/img_2.png");

        fileForNewSave.openWrite();
        fileForNewSave.writeAsBytesSync(compressed);
        fileForNewSave.createSync();

        mainIsolatePort.send(StringConstants.createdIsolateIsClosing);
        Isolate.current.kill();
      }
    });
  }
}

void main() {
  final compressedImage = CompressImageIsolate();
  compressedImage.invoke();
}
