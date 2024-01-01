import 'dart:isolate';

import 'package:flutter/cupertino.dart';

abstract class DartIsoExample2 {
  static void theMainFunc() async {
    final message = await getMessage("What are you doing");
    debugPrint("The message is $message");
  }

  static Future<String> getMessage(String forGreeting) async {
    final rp = ReceivePort();
    Isolate.spawn(
      _communicator,
      rp.sendPort,
    );

    final broadcastRp = rp.asBroadcastStream();
    final SendPort communicatorSendPort = await broadcastRp.first;
    communicatorSendPort.send(forGreeting);

    return broadcastRp.takeWhile((element) => element is String).cast<String>().take(1).first;
  }

  static void _communicator(SendPort sp) async {
    final rp = ReceivePort();
    sp.send(rp.sendPort);

    final messages = rp.takeWhile((element) => element is String).cast<String>();

    await for (var each in messages) {
      for (var eachMessage in messagesForResponse.entries) {
        if (eachMessage.key.trim().toLowerCase() == each.trim().toLowerCase()) {
          sp.send(eachMessage.value);
          continue;
        }
      }
      sp.send("I have no response for that");
    }
  }

  static const messagesForResponse = {
    "": 'Ask me a question like "How are you"',
    'Hello': "Hi",
    "How are you": "File",
    "What are you doing": "Learning about isolates in dart",
    "Are you having fun": "Yeah, sure",
  };
}
