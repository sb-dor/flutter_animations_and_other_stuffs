import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';

typedef Unit8ListCallback = Function(Uint8List data);
typedef DynamicCallback = Function(dynamic data);

class NearbyServer {
  Unit8ListCallback? onData;
  DynamicCallback? onError;

  NearbyServer(this.onData, this.onError);

  ServerSocket? server;
  bool running = false;
  List<Socket> sockets = [];

  Future<void> start() async {
    final netWorkInfo = await NetworkInfo().getWifiIP();
    if (netWorkInfo == null) return;
    runZoned(() async {
      //
      debugPrint("working here after server init");
      // bind your own device connected address
      server = await ServerSocket.bind(
        netWorkInfo,
        4000, // you can write your own port instead of 4000
      );
      running = true;
      server?.listen(_onRequest);
      const String message = "Server is listening in port 4000";
      onData!(Uint8List.fromList(message.codeUnits));
    }, onError: onError);
  }

  void _onRequest(Socket socket) {
    if (!sockets.contains(socket)) {
      sockets.add(socket);
    }
    socket.listen((event) {
      onData!(event);
    });
  }

  Future<void> stopServer() async {
    await server?.close();
    server = null;
    running = false;
  }

  void sendMessage(String message) {
    onData!(Uint8List.fromList("Message is: $message".codeUnits));
    for (final each in sockets) {
      each.write(message);
    }
  }
}
