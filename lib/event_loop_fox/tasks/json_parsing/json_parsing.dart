import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';

import 'package:flutter_animations_2/event_loop_fox/contants/isoate_string_constants.dart';

class BigJsonFileCreator {
  Future<File> jsonFile() async {
    final file = File(
      '${Directory.current.path}/lib/event_loop_fox/tasks/json_parsing/large_users.json',
    );
    final sink = file.openWrite();
    final random = Random();

    List<String> countries = ['USA', 'Germany', 'India', 'Brazil', 'Japan'];

    sink.write('{"users": [');

    for (int i = 1; i <= 100000; i++) {
      final user = {
        "id": i,
        "name": "User $i",
        "email": "user$i@example.com",
        "age": random.nextInt(73) + 18, // age between 18 and 90
        "country": countries[random.nextInt(countries.length)],
        "bio": "This is a sample bio for user $i. " * 3,
        "active": random.nextBool(),
      };

      sink.write(jsonEncode(user));
      if (i < 100000) sink.write(',');
    }

    sink.write(']}');
    await sink.flush();
    await sink.close();
    return file;
  }
}

class JsonParser {
  void invoke(File file) async {
    final newIsolatePortCompleter = Completer<SendPort>();

    final mainPort = ReceivePort();

    await Isolate.spawn(_isolate, mainPort.sendPort);

    late final StreamSubscription subs;
    subs = mainPort.listen((data) {
      if (data is SendPort && !newIsolatePortCompleter.isCompleted) {
        newIsolatePortCompleter.complete(data);
      }

      if (data is String && data == StringConstants.createdIsolateIsClosing) {
        subs.cancel();
        mainPort.close();
      }

      if (data is Map) {
        print("decodes json file in map: ${data['users'][0]}");
      }
    });

    final newIsolatePort = await newIsolatePortCompleter.future;

    newIsolatePort.send(file);
  }

  static void _isolate(SendPort mainPort) {
    final port = ReceivePort();
    mainPort.send(port.sendPort);

    port.listen((data) {
      if (data is File) {
        final Map<String, dynamic> decodedJson = jsonDecode(data.readAsStringSync());
        mainPort.send(decodedJson);
        mainPort.send(StringConstants.createdIsolateIsClosing);
        Isolate.current.kill();
      }
    });
  }
}

void main() async {
  final bigJsonFile = await BigJsonFileCreator().jsonFile();
  final jsonParser = JsonParser();
  jsonParser.invoke(bigJsonFile);
}
