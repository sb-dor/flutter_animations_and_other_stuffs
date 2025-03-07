import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ServerSocketModel {
  String ipAddress;
  List<Socket> connectedClientSocketsToServer = [];

  ServerSocketModel(this.ipAddress);

  Future<void> startServer() async {
    // final ip = InternetAddress.anyIPv4; // temp
    final server =
        await ServerSocket.bind(ipAddress, 3000); // whatever port you want

    server.listen(
      (socket) {
        _handleConnection(socket);
      },
      onError: () {
        debugPrint("error connection");
      },
      onDone: () {},
    );
  }

  void _handleConnection(Socket clientSocket) {
    clientSocket.write(
        "Success fully joined to the server"); // writing to client from server

    clientSocket.listen(
      (Uint8List data) {
        // coming information from client

        String messageFromBytes = String.fromCharCodes(data);

        for (final each in connectedClientSocketsToServer) {
          each.write("Someone wrote: $messageFromBytes");
        }

        if (!connectedClientSocketsToServer
            .any((el) => el.address == clientSocket.address)) {
          connectedClientSocketsToServer.add(clientSocket);
        }

        clientSocket.write("Server: you are writing : $messageFromBytes");
      },
      onError: (error) {
        debugPrint("client error connection $error");
        clientSocket.close();
      },
      onDone: () {
        debugPrint("client left the server");
        clientSocket.close();
      },
    );
  }
}
