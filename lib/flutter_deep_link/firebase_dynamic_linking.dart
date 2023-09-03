import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class FirebaseDynamicLinking {
  late final Uri dynamicLink;

  final dynamicLinkParams = DynamicLinkParameters(
    link: Uri.parse("https://flutterhome.page.link"),
    uriPrefix: "https://flutterhome.page.link",
    androidParameters: const AndroidParameters(packageName: "com.example.app.android"),
    iosParameters: const IOSParameters(bundleId: "com.example.app.ios"),
  );

  void init() async {
    dynamicLink = await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);
  }
}
