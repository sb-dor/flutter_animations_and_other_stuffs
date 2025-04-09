// Primitive Types
//
// These are basic building blocks of data. They are not made of other objects and are typically built into the language.
//
// In Dart, primitive types include:
// 	int, double, bool, String, null

// ✅ Primitive types are safe to send between isolates because they are simple and don’t hold references.

// 2. Non-Primitive Objects
//
// These are more complex data types that are made from other values. They may contain fields, methods, and references to memory.
// Even something like a DateTime object or a TextEditingController is non-primitive.

// class Person {
//   String name;
//   int age;
//
//   Person(this.name, this.age);
// }

import 'dart:async';
import 'dart:isolate';

import 'package:flutter_animations_2/event_loop_fox/contants/isoate_string_constants.dart';

class Game {
  Game({required this.id, required this.name, required this.price});

  final int id;
  final String name;
  final double price;
}

class Playstation {
  Playstation(this.games);

  final List<Game> games;
}

void main() {
  final tlou2 = Game(id: 1, name: "The last of us 2", price: 40);

  final rdr2 = Game(id: 2, name: "Red dead redemption 2", price: 50);

  final playstation = Playstation([tlou2, rdr2]);

  print("playstations hashcode: ${playstation.hashCode}");
  for (var each in playstation.games) {
    print("game ${each.name} hashCode: ${each.hashCode}");
  }
  print('--------------');
  print('--------------');
  print('--------------');

  _runIsolate(playstation);
}

void _runIsolate(Playstation playstation) async {
  final createdIsolatePortCompleter = Completer<SendPort>();

  final mainIsolatePort = ReceivePort();

  await Isolate.spawn(_isolate, mainIsolatePort.sendPort);

  late final StreamSubscription subs;

  subs = mainIsolatePort.listen((data) {
    if (data is SendPort && !createdIsolatePortCompleter.isCompleted) {
      createdIsolatePortCompleter.complete(data);
    }

    if (data is String && data == StringConstants.createdIsolateIsClosing) {
      subs.cancel();
      mainIsolatePort.close();
    }
  });

  final createdIsolatePort = await createdIsolatePortCompleter.future;

  createdIsolatePort.send(playstation);
}

void _isolate(SendPort mainIsolatePort) {
  final createdIsolatePort = ReceivePort();

  mainIsolatePort.send(createdIsolatePort.sendPort);

  createdIsolatePort.listen((data) {
    if (data is Playstation) {
      print("playstations hashcode: ${data.hashCode}");
      for (var each in data.games) {
        print("game ${each.name} hashCode: ${each.hashCode}");
      }
      mainIsolatePort.send(StringConstants.createdIsolateIsClosing);
      Isolate.current.kill();
    }
  });
}
