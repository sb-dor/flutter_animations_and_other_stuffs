do not forget to visit documentation of this package

1. https://pub.dev/packages/flutter_background_service

add this package in your pubspec.yaml file

    dependencies:
      flutter:
        sdk: flutter
    flutter_background_service: {version}

do not forget to add this in your Info.plist file for ios:

    <key>BGTaskSchedulerPermittedIdentifiers</key>
    <array>
        <string>dev.flutter.background.refresh</string>
    </array>

add this line in your AppDelegate.swift file:

    SwiftFlutterBackgroundServicePlugin.taskIdentifier = "your.custom.task.identifier"

if you will get error from "FlutterScanBluetoothPlugin" or some another plugin after closing app 
try to use "try-catch" for kotlin or java and "do-catch" for swift in file where it throws an error
for example in file FlutterScanBluetoothPlugin.kt this function is throwing an error on "onViewDestroy" method:

     override fun onDetachedFromActivity() {
        activityBinding.removeRequestPermissionsResultListener(this)
        activityBinding.removeActivityResultListener(this)
        onViewDestroy()
     }

just try to use try-catch:

     override fun onDetachedFromActivity() {
        activityBinding.removeRequestPermissionsResultListener(this)
        activityBinding.removeActivityResultListener(this)
        try {
            onViewDestroy()
        } catch (e: Exception) {
        }
    }