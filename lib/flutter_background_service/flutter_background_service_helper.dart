import 'dart:async';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations_2/firebase_push_notification/firebase_push_not.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FlutterBackgroundServiceHelper {
  static Future<void> initService() async {
    try {
      final service = FlutterBackgroundService();

      await service.configure(
          iosConfiguration: IosConfiguration(
              // auto start service
              autoStart: true,

              // this will be executed when app is in foreground in separated isolate
              onForeground: onStart,

              // you have to enable background fetch capability on xcode project
              onBackground: onIosBackground),
          androidConfiguration:
              AndroidConfiguration(onStart: onStart, isForegroundMode: true));

      await service.startService();
    } catch (e) {
      debugPrint("init service error is : $e");
    }
  }

  @pragma('vm:entry-point')
  static Future<void> onStart(ServiceInstance service) async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      DartPluginRegistrant.ensureInitialized();
      if (service is AndroidServiceInstance) {
        service.on('setAsForeground').listen((event) {
          service.setAsForegroundService();
        });

        service.on('setAsBackground').listen((event) {
          service.setAsBackgroundService();
        });
      }
      service.on('stopService').listen((event) {
        service.stopSelf();
      });
      Timer.periodic(const Duration(seconds: 60), (timer) async {
        //do something here
        await Firebase.initializeApp();
        await FirebasePushNot.initForeGroundNotification();
      });
    } catch (e) {
      debugPrint("background onStart error is : $e");
    }
  }

  @pragma('vm:entry-point')
  static Future<bool> onIosBackground(ServiceInstance service) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();

    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.reload();
    final log = preferences.getStringList('log') ?? <String>[];
    log.add(DateTime.now().toIso8601String());
    await preferences.setStringList('log', log);

    return true;
  }
}
