import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class BatteryChannel {
  static const channel = MethodChannel('get/flutter/buttery');

  static String getButteryMethod = 'getButteryLevel';

  static String nativePopupChannel = 'popupMethod';

  static Future<String> getButtery() async {
    String butteryLevel = '';
    try {
      var result = await channel.invokeMethod(getButteryMethod);
      butteryLevel = "Buttery is $result";
      debugPrint("getting value $result");
    } catch (e) {
      debugPrint("e");
    }
    return butteryLevel;
  }

  static void callPopUpMethod() async {
    await channel.invokeMethod(nativePopupChannel);
  }
}
