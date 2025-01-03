import UIKit
import Flutter
import YandexMapsMobile
import FirebaseCore
//import flutter_local_notifications

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    FirebaseApp.configure()

    //cause of putting this "do-catch" is that after clicking upon the "flutter_background_service" notification

    //yandex map throws an exception
    //the key is already locked and you cannot use it
    do{
        YMKMapKit.setLocale("ru_RU") // Your preferred language. Not required, defaults to system language
        YMKMapKit.setApiKey(Secrets.apiYandexKey) // class name and static getter
    } catch {

    }



//    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
//        GeneratedPluginRegistrant.register(with: registry)
//    }

    if #available(iOS 10.0, *) {
    UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
