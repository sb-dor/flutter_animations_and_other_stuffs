import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animations_2/local_notification/awesome_notification_helper.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebasePushNot {
  static final firebaseMessaging = FirebaseMessaging.instance;

  // static final localNotification = FlutterLocalNotificationsPlugin();

  static Future<void> backgroundMessageHandler(RemoteMessage? message) async {
    if (message == null) return;
    debugPrint("Title: ${message.notification?.title}");
    debugPrint("body: ${message.notification?.body}");
    debugPrint("playload: ${message.data}");
    await AwesomeNotificationsHelper.showAwesomeNotification(
        title: message.notification?.title ?? '',
        body: message.notification?.body ?? '',
        imageType: "welcome_type",
        image: null);
  }

  static Future<void> initBackGroundNotification() async {
    //this lines
    await firebaseMessaging.requestPermission();
    //and this is for getting firebase token
    final firebaseToken = await firebaseMessaging.getToken();
    //
    debugPrint("firebase token: $firebaseToken");

    //real fun look like this
    //-> FirebaseMessaging.onBackgroundMessage((message) async {});
    //but what we put another fun that takes same parameter it will be good
    FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
  }

  static Future<void> foregroundMessageHandler(RemoteMessage? message) async {
    if (message == null) return;
    debugPrint("Title: ${message.notification?.title}");
    debugPrint("body: ${message.notification?.body}");
    debugPrint("playload: ${message.data}");
    await AwesomeNotificationsHelper.showAwesomeNotification(
        title: message.notification?.title ?? '',
        body: message.notification?.body ?? '',
        imageType: "welcome_type",
        image: null);
  }

  static Future<void> initForeGroundNotification() async {
    FirebaseMessaging.onMessage.listen(foregroundMessageHandler);
  }
}
