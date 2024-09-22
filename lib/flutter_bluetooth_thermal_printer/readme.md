add this packages in your pubspec.yaml file


    geolocator: ^13.0.1 # for android 10 permission for bluetooth feature
    flutter_blue_plus: ^1.32.12
    flutter_reactive_ble: ^5.3.1
    flutter_pos_printer_platform_image_3: ^1.2.0
    flutter_esc_pos_utils: ^1.0.1


add this permissions in your AndroidManifest.xml file:

    <!-- required for API 18 - 30 -->
    <uses-permission android:name="android.permission.BLUETOOTH" />
    <uses-permission android:name="android.permission.BLUETOOTH_ADMIN" />

    <uses-permission android:name="android.permission.BLUETOOTH_PRIVILEGED" />
    <!-- Needed only if your app looks for Bluetooth devices.
         If your app doesn't use Bluetooth scan results to derive physical
         location information, you can strongly assert that your app
         doesn't derive physical location. -->

    <!-- Needed only if your app makes the device discoverable to Bluetooth
         devices. -->
    <uses-permission android:name="android.permission.BLUETOOTH_ADVERTISE" />
    <!-- Needed only if your app communicates with already-paired Bluetooth
         devices. -->
    <!-- API 31+ -->
    <uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
    <uses-permission android:name="android.permission.BLUETOOTH_SCAN" />
    <!-- bibo01: hardware option -->
    <uses-feature
        android:name="android.hardware.bluetooth"
        android:required="false" />
    <uses-feature
        android:name="android.hardware.bluetooth_le"
        android:required="false" />
    <!-- required for API 23 - 30 -->
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />
