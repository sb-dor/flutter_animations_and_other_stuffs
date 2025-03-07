import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter_app_badger/flutter_app_badger.dart';

class AwesomeNotificationsHelper {
  //main init. you should add this line in animated_drag_drop_app.dart
  static Future<void> initAwesomeNotifications() async {
    AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
              channelKey: "alshema_local_notify_id",
              //here can be any id. Putting id do not forget to put this id everywhere in channels_key
              channelName: "basic notifications",
              channelDescription: "Notification channel for basic test",
              importance: NotificationImportance.Max,
              channelShowBadge: true,
              onlyAlertOnce: true,
              playSound: true,
              criticalAlerts: true)
        ],
        debug: true);

    AwesomeNotifications().isNotificationAllowed().then((value) {
      if (!value) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  static Future<void> showAwesomeNotification(
      {required String title,
      required String body,
      required String imageType,
      required String? image}) async {
    switch (imageType) {
      case "promo_type":
        await showNotificationWithBigImageImage(
            title: title, body: body, image: image);
        break;
      case "welcome_type":
        await showSimpleNotification(title: title, body: body);
        break;
    }
  }

  static Future<void> showNotificationWithBigImageImage(
      {required String title,
      required String body,
      required String? image}) async {
    // debugPrint("notification image: ${ApiSettings.MAIN_URL}/get-promo-banner-img/$image");
    //if you want to show notification every time create and save "id" in shared_preferences and get that
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 1,
            channelKey: "alshema_local_notify_id",
            title: title,
            body: body,
            bigPicture: "server-url/get-promo-banner-img/$image",
            notificationLayout: image == null
                ? NotificationLayout.Messaging
                : NotificationLayout.BigPicture));
  }

  static Future<void> showSimpleNotification(
      {required String title, required String body}) async {
    //if you want to show notification every time create and save "id" in shared_preferences and get that
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 2,
            channelKey: "alshema_local_notify_id",
            title: title,
            body: body));
  }

// function for getting and saving last notification id:
// re-comment this in your own code

// static Future<int> _lastNotificationId() async {
//   int lastNotificationId = await SharedPrefer.getIntByKey(key: 'last_notify_id') ?? 0;
//   lastNotificationId++;
//   await SharedPrefer.setIntWithKey(key: "last_notify_id", value: lastNotificationId);
//   return lastNotificationId;
// }

  static Future<void> _clearAllNotifications() async {
    await AwesomeNotifications().cancelAll();
    await _updateNotificationBadge();
  }

  static Future<void> _updateNotificationBadge() async {
    // await FlutterAppBadger.removeBadge();
    // await FlutterAppBadger.updateBadgeCount(0);
  }
}
