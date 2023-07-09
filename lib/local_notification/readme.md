all data for creating local notification is here

at first you need to add this packages in your pubspec.yaml file:

1. flutter_local_notifications: version

----
some youtube url for more details:

1. https://youtu.be/g2V7y0eTTSE

----

you need add these lines of code in you AndroidManifest file

in meta-data in field "any_id" put field that you write in AndroidNotificationDetails in
LocalNotification class

    <meta-data android:name="com.google.firebase.messaging.default_notification_channel_id"
    android:value="any_id" />

    <intent-filter>

    <action android:name="FLUTTER_NOTIFICATION_CLICK" />

    <category android:name="android.intent.category.DEFAULT" />

    </intent-filter>

----
do Android and Ios integration from docs
on any app debug issues try to change:

    coreLibraryDesugaring 'com.android.tools:desugar_jdk_libs:1.0.9'

in android/app/build.gradle