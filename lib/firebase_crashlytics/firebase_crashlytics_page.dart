import 'package:flutter/material.dart';

class FirebaseCrashlyticsPage extends StatelessWidget {
  const FirebaseCrashlyticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Firebase Crashlytics")),
        body: Center(
            child: TextButton(
                onPressed: () => throw Exception(),
                child: const Text("Check Your Firebase Crashlytics dashboard"))));
  }
}
