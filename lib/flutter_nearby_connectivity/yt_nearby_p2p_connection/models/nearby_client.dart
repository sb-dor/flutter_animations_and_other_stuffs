import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

typedef Unit8ListCallback = Function(Uint8List data);
typedef DynamicCallback = Function(dynamic data);

class NearbyClient {
  String? hostName;
  int? port;
  Unit8ListCallback? onData;
  DynamicCallback? onError;

  NearbyClient({this.hostName, this.port, this.onData, this.onError});

  bool isConnected = false;

  Socket? socket;

  void connect() async {
    if (hostName == null || port == null) return;
    socket = await Socket.connect(hostName, port!);
    isConnected = true;
    socket?.listen(
      (event) {
        onData!(event);
      },
      onError: onError,
      onDone: () async {
        final deviceInfoPlugin = DeviceInfoPlugin();


        String deviceInfo = '';

        if (Platform.isAndroid) {
          deviceInfo = await deviceInfoPlugin.androidInfo.then((value) => value.device);
        } else if (Platform.isIOS) {
          deviceInfo = await deviceInfoPlugin.iosInfo.then((value) => value.name);
        } else if (Platform.isWindows) {
          deviceInfo = await deviceInfoPlugin.windowsInfo.then((value) => value.productName);
        } else if (Platform.isLinux) {
          deviceInfo = await deviceInfoPlugin.linuxInfo.then((value) => value.name);
        } else if (Platform.isMacOS) {
          deviceInfo = await deviceInfoPlugin.macOsInfo.then((value) => value.computerName);
        }

        disconnect(deviceInfo);
      },
    );
  }

  void write(String message) {
    socket?.write(message);
  }

  void disconnect(String deviceInfo) {
    final message = "Disconnected from $deviceInfo";
    write(message);
    if (socket != null) {
      socket?.destroy();
      isConnected = false;
    }
  }
}
