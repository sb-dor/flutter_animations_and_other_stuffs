import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter_app_badger/flutter_app_badger.dart';

class AwesomeNotificationsHelper {
  //initial notification
  //to show notification in background do not forget to initialize all data that you want to use,
  //otherwise the notification will not work

  static Future<void> initAwesomeNotifications() async {
    //   await AwesomeNotifications().initialize(
    //       null,
    //       [
    //         NotificationChannel(
    //             channelKey: "alshema_local_notify_id",
    //             channelName: "basic notifications",
    //             channelDescription: "Notification channel for basic test",
    //             importance: NotificationImportance.Max,
    //             channelShowBadge: true,
    //             onlyAlertOnce: true,
    //             playSound: true,
    //             criticalAlerts: true)
    //       ],
    //       debug: true);
    await _clearAllNotifications();
  }

  static Future<void> showAwesomeNotification(
      {required Map<String, dynamic> notification, required bool offline}) async {
    if (notification.containsKey("image_url") && notification['image_url'] != null) {
      await _showNotificationWithBigImageImage(notification: notification, offline: offline);
    } else {
      await _showSimpleNotification(notification: notification, offline: offline);
    }
  }

  static Future<void> _showNotificationWithBigImageImage(
      {required Map<String, dynamic> notification, required bool offline}) async {
    // debugPrint("notification image: ${ApiSettings.MAIN_URL}$notification");
    //
    // //notify model is my own created model
    // //i wrote like this cause' AwesomeNotification has same model
    // notifyModel.NotificationModel notificationModel =
    //     notifyModel.NotificationModel.fromJson(notification);
    //
    // if ((notificationModel.visible ?? false) == true) {
    //   await SqfliteDatabaseHelper.setNotificationToDb(notificationModel: notificationModel);
    // }
    // GlobalContextHelper.globalNavigatorContext.currentContext
    //     ?.read<MainNotificationsScreenBloc>()
    //     .add(NotificationsScreenInitEvent());
    //
    // debugPrint("working anywhere");
    //
    // await SharedPrefer.initSharedPrefer();
    //
    // // bool permissionOfNot =
    // //     await SharedPrefer.getBoolByKey(key: 'permission_to_notification') ?? true;
    //
    // var notificationPermission = await Permission.notification.status;
    //
    // debugPrint("permissionOfNot : ${notificationPermission.isGranted}");
    //
    // if (!notificationPermission.isGranted) return;
    //
    // AwesomeNotifications().createNotification(
    //     content: NotificationContent(
    //         id: await _lastNotificationId(),
    //         channelKey: "alshema_local_notify_id",
    //         title: notification['title'],
    //         body: notification['message'],
    //         bigPicture: "${ApiSettings.MAIN_URL}${notification['image_url']}",
    //         notificationLayout: notification['image_url'] == null
    //             ? NotificationLayout.Default
    //             : NotificationLayout.BigPicture));

    await _updateNotificationBadge();
  }

  static Future<void> _showSimpleNotification(
      {required Map<String, dynamic> notification, required bool offline}) async {
    //notify model is my own created model
    //i wrote like this cause' AwesomeNotification has same model
    // notifyModel.NotificationModel notificationModel =
    //     notifyModel.NotificationModel.fromJson(notification);
    //
    // if ((notificationModel.visible ?? false) == true) {
    //   await SqfliteDatabaseHelper.setNotificationToDb(notificationModel: notificationModel);
    // }
    // GlobalContextHelper.navigatorKey.currentContext
    //     ?.read<MainNotificationsScreenBloc>()
    //     .add(NotificationsScreenInitEvent());
    //
    // debugPrint("working anywhere");
    //
    // await SharedPrefer.initSharedPrefer();

    // bool permissionOfNot =
    //     await SharedPrefer.getBoolByKey(key: 'permission_to_notification') ?? true;

    // var notificationPermission = await Permission.notification.status;
    //
    // if (!notificationPermission.isGranted) return;
    //
    // AwesomeNotifications().createNotification(
    //     content: NotificationContent(
    //         id: await _lastNotificationId(),
    //         channelKey: "alshema_local_notify_id",
    //         title: notification['title'],
    //         body: notification['message']));

    await _updateNotificationBadge();
  }

  static Future<int> _lastNotificationId() async {
    // int lastNotificationId = await SharedPrefer.getIntByKey(key: 'last_notify_id') ?? 0;
    // lastNotificationId++;
    // await SharedPrefer.setIntWithKey(key: "last_notify_id", value: lastNotificationId);
    // return lastNotificationId;

    // line below is not usable code I just wrote this avoid function error
    return 0;
  }

  static Future<void> _clearAllNotifications() async {
    await AwesomeNotifications().cancelAll();
    await _updateNotificationBadge();
  }

  static Future<void> _updateNotificationBadge() async {
    // await FlutterAppBadger.removeBadge();
    // await FlutterAppBadger.updateBadgeCount(0);
  }
}
