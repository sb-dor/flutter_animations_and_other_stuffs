import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  static final _notification = FlutterLocalNotificationsPlugin();

  //all initial for any devices
  static Future<void> initLocalNotification() async {
    var androidInit = const AndroidInitializationSettings('mipmap/ic_launcher');
    var iosAndMacInit = const DarwinInitializationSettings();
    var linuxInit = const LinuxInitializationSettings(defaultActionName: 'any');
    var initialSettings = InitializationSettings(
        android: androidInit, iOS: iosAndMacInit, macOS: iosAndMacInit, linux: linuxInit);

    await _notification.initialize(initialSettings);
  }

  //call this fun for showing local notification
  static Future<void> showNotification(
      {int id = 0, required String title, required String body, var playLoad}) async {
    AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails(
        "any_id", "channel_name",
        playSound: true, importance: Importance.max, priority: Priority.high);

    var notDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: const DarwinNotificationDetails());
    await _notification.show(id, title, body, notDetails);
  }
}
