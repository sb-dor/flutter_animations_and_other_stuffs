import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animations_2/local_notification/awesome_notification_helper.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebasePushNot {
  static final firebaseMessaging = FirebaseMessaging.instance;

  // static final localNotification = FlutterLocalNotificationsPlugin();

  // to subscribe to the topic
  static Future<String?> initTopic() async {
    await firebaseMessaging.requestPermission();

    final firebaseToken = await firebaseMessaging.getToken();

    await firebaseMessaging.subscribeToTopic('name_of_your_any_topic');

    initBackGroundNotification();

    initForeGroundNotification();

    return firebaseToken;
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
    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  }

  static Future<void> initForeGroundNotification() async {
    FirebaseMessaging.onMessage.listen(_foregroundMessageHandler);
  }

  static Future<void> _backgroundMessageHandler(RemoteMessage? message) async {
    if (message == null) return;
    debugPrint("Title: ${message.notification?.title}");
    debugPrint("body: ${message.notification?.body}");
    debugPrint("playload of background listener: ${message.data}");

    // debugPrint("payLoad: ${message.data}");
    //
    // if sending from laravel is json type
    // Map<String, dynamic> notification = jsonDecode(message.data['title']);

    // await AwesomeNotificationsHelper.showAwesomeNotification(
    //     notification: notification['notification'], offline: false);

    await AwesomeNotificationsHelper.showAwesomeNotification(
        title: message.notification?.title ?? '',
        body: message.notification?.body ?? '',
        imageType: "welcome_type",
        image: null);
  }

  static Future<void> _foregroundMessageHandler(RemoteMessage? message) async {
    if (message == null) return;

    // debugPrint("payLoad: ${message.data}");
    //
    // if sending from laravel is json type
    // Map<String, dynamic> notification = jsonDecode(message.data['title']);

    // await AwesomeNotificationsHelper.showAwesomeNotification(
    //     notification: notification['notification'], offline: false);

    debugPrint("Title: ${message.notification?.title}");
    debugPrint("body: ${message.notification?.body}");
    debugPrint("playload of foreground listener: ${message.data}");
    await AwesomeNotificationsHelper.showAwesomeNotification(
        title: message.notification?.title ?? '',
        body: message.notification?.body ?? '',
        imageType: "welcome_type",
        image: null);
  }
}
