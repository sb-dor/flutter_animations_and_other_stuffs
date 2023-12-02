first of all add package in your pubspec.yaml file:

    dependencies:
      flutter:
        sdk: flutter
    permission_handler: {version}

for getting permissions of anything for android visit this website:

1. https://developer.android.com/reference/android/Manifest.permission

for getting permissions of anything for ios visit this website

2. https://developer.apple.com/documentation/uikit/protecting_the_user_s_privacy/requesting_access_to_protected_resources

for more information about permission handler check these links:

1. https://pub.dev/packages/permission_handler
2. https://github.com/baseflow/flutter-permission-handler
3. https://youtu.be/K7kw0T8k2cg?si=_Fxn2uI29Y12flCq

_____________________________________________________________________________________
    <uses-permission android:name="android.permission.CAMERA" />

    <uses-permission android:name="android.permission.RECORD_AUDIO" />

    <uses-permission android:name="android.permission.POST_NOTIFICATIONS" />

    <uses-permission android:name="android.permission.BLUETOOTH" />

    <uses-permission android:name="android.permission.BLUETOOTH_SCAN" />

    <uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />

    <uses-permission android:name="android.permission.BLUETOOTH_ADMIN" />

    <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />

    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />

     <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>

    <uses-permission android:name="android.permission.INTERNET" />

    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />


    android.permission.CAMERA maps to NSCameraUsageDescription in Info.plist.

    android.permission.RECORD_AUDIO maps to NSMicrophoneUsageDescription in Info.plist.

    android.permission.POST_NOTIFICATIONS doesn't have a direct iOS equivalent.

    android.permission.BLUETOOTH maps to NSBluetoothPeripheralUsageDescription in Info.plist.

    android.permission.BLUETOOTH_SCAN doesn't have a direct iOS equivalent.

    android.permission.BLUETOOTH_CONNECT doesn't have a direct iOS equivalent.

    android.permission.BLUETOOTH_ADMIN maps to NSBluetoothAlwaysUsageDescription in Info.plist.

    android.permission.FOREGROUND_SERVICE doesn't have a direct iOS equivalent.

    android.permission.READ_EXTERNAL_STORAGE maps to NSPhotoLibraryUsageDescription in Info.plist.

    android.permission.INTERNET doesn't require a specific iOS permission as internet access is allowed by default.

    android.permission.ACCESS_FINE_LOCATION maps to NSLocationWhenInUseUsageDescription in Info.plist

    if you need location access while the app is in the foreground. If you need background location access, you should use NSLocationAlwaysUsageDescription.
   

    how to add to the Info.plist file :
    
    <key>NSCameraUsageDescription</key>
    <string>To capture profile photo please grant camera access</string>
