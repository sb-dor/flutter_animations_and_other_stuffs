all data for creating firebase push notification is here

at first you need to add this packages in your pubspec.yaml file:

    firebase_core: version
    firebase_messaging: version

----
some youtube url for more details:

1. https://youtu.be/k0zGEbiDJcQ

add this implementation in android\app\build.gradle:

    dependencies {
        implementation 'com.google.firebase:firebase-messaging:23.1.2'
    }

and check out that you added this classpath in android\build.gradle:
    
    dependencies {
        classpath 'com.google.gms:google-services:4.3.15'
    }

before running the app make sure that you added this firebase initializeApp in your main.dart file:

    void main() async {
        WidgetsFlutterBinding.ensureInitialized();
        await Firebase.initializeApp();
    }