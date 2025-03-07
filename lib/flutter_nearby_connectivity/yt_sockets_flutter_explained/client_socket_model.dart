import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClientSocketModel {
  String ipAddress;

  ClientSocketModel(this.ipAddress);

  Future<void> connectToTheServer() async {
    final serverListener =
        await Socket.connect(ipAddress, 3000); // write same port of server

    // listen all messages that coming from server
    serverListener.listen(
      (Uint8List data) {
        final messageFromBytes = String.fromCharCodes(data);

        debugPrint("server response: $messageFromBytes");
      },
      onError: (error) {
        debugPrint("server error $error");
        serverListener
            .destroy(); // instead of writing "close()" method in client side serverListener should be destroyed
      },
      onDone: () {
        debugPrint("server left");
        serverListener
            .destroy(); // instead of writing "close()" method in client side serverListener should be destroyed
      },
    );
  }
}
