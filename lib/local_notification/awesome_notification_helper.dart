import 'package:awesome_notifications/awesome_notifications.dart';

class AwesomeNotificationsHelper {
  //main init. you should add this line in main.dart
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
        await showNotificationWithBigImageImage(title: title, body: body, image: image);
        break;
      case "welcome_type":
        await showSimpleNotification(title: title, body: body);
        break;
    }
  }

  static Future<void> showNotificationWithBigImageImage(
      {required String title, required String body, required String? image}) async {
    // debugPrint("notification image: ${ApiSettings.MAIN_URL}/get-promo-banner-img/$image");
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 1,
            channelKey: "alshema_local_notify_id",
            title: title,
            body: body,
            bigPicture: "server-url/get-promo-banner-img/$image",
            notificationLayout:
                image == null ? NotificationLayout.Messaging : NotificationLayout.BigPicture));
  }

  static Future<void> showSimpleNotification({required String title, required String body}) async {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 2, channelKey: "alshema_local_notify_id", title: title, body: body));
  }
}
