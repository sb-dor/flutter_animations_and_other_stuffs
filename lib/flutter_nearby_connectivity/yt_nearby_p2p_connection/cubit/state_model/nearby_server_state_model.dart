import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations_2/flutter_nearby_connectivity/yt_nearby_p2p_connection/models/nearby_client.dart';
import 'package:flutter_animations_2/flutter_nearby_connectivity/yt_nearby_p2p_connection/models/nearby_server.dart';
import 'package:network_discovery/network_discovery.dart';

class NearbyServerStateModel {
  NearbyServer? server;
  NearbyClient? client;

  List<String> serverComingData = [];

  TextEditingController messageController = TextEditingController(text: '');

  // for client
  Stream<NetworkAddress>? stream;

  List<NetworkAddress> networkAddress = [];

  List<File> files = [];

  Timer? tempTimerForFile;

  List<int> filesData = [];

  Future<String> getDeviceName() async {
    final deviceInfoPlugin = DeviceInfoPlugin();

    String deviceInfo = '';

    if (Platform.isAndroid) {
      deviceInfo =
          await deviceInfoPlugin.androidInfo.then((value) => value.device);
    } else if (Platform.isIOS) {
      deviceInfo = await deviceInfoPlugin.iosInfo.then((value) => value.name);
    } else if (Platform.isWindows) {
      deviceInfo =
          await deviceInfoPlugin.windowsInfo.then((value) => value.productName);
    } else if (Platform.isLinux) {
      deviceInfo = await deviceInfoPlugin.linuxInfo.then((value) => value.name);
    } else if (Platform.isMacOS) {
      deviceInfo =
          await deviceInfoPlugin.macOsInfo.then((value) => value.computerName);
    }

    return deviceInfo;
  }
}
