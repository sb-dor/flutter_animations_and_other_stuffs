for checking any bugs or exceptions in your app use Firebase Crashlytics first visit firebase
crashlytics docs.

1. https://pub.dev/packages/firebase_crashlytics
2. https://firebase.google.com/docs/crashlytics/get-started?platform=flutter&hl=ru

first add this package in your app:

    firebase_core: version
    firebase_crashlytics: version

after adding this packages add this code in your main.dart file

    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FlutterError.onError = (errorDetails) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
    };


> **_NOTE:_** remember do it all stuff after renaming package name, because the name of project will change 
in build.gradle file and in info.plist file. 
