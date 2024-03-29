import UIKit
import Flutter
import YandexMapsMobile

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    //cause of putting this "do-catch" is that after clicking upon the "flutter_background_service" notification

    //yandex map throws an exception
    //the key is already locked and you cannot use it
    try{
        YMKMapKit.setLocale("ru_RU") // Your preferred language. Not required, defaults to system language
        YMKMapKit.setApiKey("XXXXXXXXXXXXXXXXXXXX") // Your generated API key
    } catch {

    }



    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
        GeneratedPluginRegistrant.register(with: registry)
    }

    if #available(iOS 10.0, *) {
    UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
