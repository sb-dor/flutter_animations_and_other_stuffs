import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

class UpGraderPage extends StatefulWidget {
  const UpGraderPage({Key? key}) : super(key: key);

  @override
  State<UpGraderPage> createState() => _UpGraderPageState();
}

class _UpGraderPageState extends State<UpGraderPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 5), () async {
      await Upgrader.clearSavedSettings();
      var upGrader = Upgrader.sharedInstance;
      await upGrader.initialize();
      String? currentVersion = upGrader.currentInstalledVersion();
      String? storeVersion = upGrader.currentAppStoreVersion();
      String? message = upGrader.message();
      String? appStoreLink = upGrader.currentAppStoreListingURL();
      bool isUpdateAvailable = upGrader.isUpdateAvailable();

      debugPrint("current version : $currentVersion");
      debugPrint("store version : $storeVersion");
      debugPrint("message is : $message");
      debugPrint("app store link : $appStoreLink");
      debugPrint("is update available $isUpdateAvailable");

      if (isUpdateAvailable && context.mounted) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => WillPopScope(
                  onWillPop: () async => false,
                  child: AlertDialog(
                    title: const Text("Обновить?"),
                    content: Text(message),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context), child: const Text("ПОЗЖЕ")),
                      TextButton(
                          onPressed: () => Upgrader.sharedInstance.onUserUpdated(context, false),
                          child: const Text("ОБНОВИТЬ"))
                    ],
                  ),
                ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upgrader Checker")),
      body: const Center(child: Text("Checking")),
    );
  }
}
