import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
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
    try {
      if (hostName == null || port == null) return;
      socket = await Socket.connect(hostName, port!);
      isConnected = true;
      String deviceName = await getDeviceName();
      write("successfully connected with the ${await getDeviceName()}"); // write to the server
      onData!(Uint8List.fromList("successfully connected to the $deviceName".codeUnits)); // write to yourself
      socket?.listen(
        (event) {
          onData!(event);
        },
        onError: onError,
        // "onDone"  will be worked only then when user disconnects from server
        onDone: () async {
          disconnect(await getDeviceName());
        },
      );
    } catch (e) {
      debugPrint("$e");
    }
  }

  
  // write means that you are writing something to the server
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

  Future<String> getDeviceName() async {
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
    return deviceInfo;
  }
}
