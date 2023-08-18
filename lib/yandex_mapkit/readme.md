for more information see:

1. https://pub.dev/packages/yandex_mapkit 
2. https://github.com/Unact/yandex_mapkit


Initializing for iOS

1. Add import YandexMapsMobile to ios/Runner/AppDelegate.swift
2. Add YMKMapKit.setApiKey("YOUR_API_KEY") inside func application in ios/Runner/AppDelegate.swift
3. Specify your API key in the application delegate ios/Runner/AppDelegate.swift
4. Uncomment platform :ios, '9.0' in ios/Podfile and change to platform :ios, '12.0'


ios/Runner/AppDelegate.swift:

      import UIKit
      import Flutter
      import YandexMapsMobile
   
      @UIApplicationMain
      @objc class AppDelegate: FlutterAppDelegate {
         override func application(
            _ application: UIApplication,
            didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
         ) -> Bool {
            YMKMapKit.setLocale("ru_RU") // Your preferred language. Not required, defaults to system language
            YMKMapKit.setApiKey("YOUR_API_KEY") // Your generated API key
            GeneratedPluginRegistrant.register(with: self)
            return super.application(application, didFinishLaunchingWithOptions: launchOptions)
         }
      }

Initializing for Android:  

1. Add dependency implementation 'com.yandex.android:maps.mobile:4.3.2-full' to android/app/build.gradle
2. Add permissions <uses-permission android:name="android.permission.INTERNET"/> 
   and <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/> 
   to android/app/src/main/AndroidManifest.xml
3. Add import com.yandex.mapkit.MapKitFactory;
   to android/app/src/main/.../MainActivity.java/android/app/src/main/.../MainActivity.kt
4. MapKitFactory.setApiKey("YOUR_API_KEY");
   inside method onCreate in android/app/src/main/.../MainActivity.java/android/app/src/main/.../MainActivity.kt
5. Specify your API key in the application delegate android/app/src/main/.../MainActivity.java/android/app/src/main/.../MainActivity.kt

android/app/build.gradle:

      dependencies {
         implementation 'com.yandex.android:maps.mobile:4.3.2-full'
      }

For Java projects:
android/app/src/main/.../MainActivity.java:

      import androidx.annotation.NonNull;
      import io.flutter.embedding.android.FlutterActivity;
      import io.flutter.embedding.engine.FlutterEngine;
      import io.flutter.plugins.GeneratedPluginRegistrant;
      import com.yandex.mapkit.MapKitFactory;
   
      public class MainActivity extends FlutterActivity {
         @Override
         public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
            MapKitFactory.setLocale("ru_RU"); // Your preferred language. Not required, defaults to system language
            MapKitFactory.setApiKey("YOUR_API_KEY"); // Your generated API key
            super.configureFlutterEngine(flutterEngine);
         }
      }


For Kotlin projects
android/app/src/main/.../MainActivity.kt

      import androidx.annotation.NonNull
      import io.flutter.embedding.android.FlutterActivity
      import io.flutter.embedding.engine.FlutterEngine
      import io.flutter.plugins.GeneratedPluginRegistrant
      import com.yandex.mapkit.MapKitFactory
      
      class MainActivity: FlutterActivity() {
         override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
            MapKitFactory.setLocale("ru_RU") // Your preferred language. Not required, defaults to system language
            MapKitFactory.setApiKey("YOUR_API_KEY") // Your generated API key
            super.configureFlutterEngine(flutterEngine)
         }
      }