import 'package:flutter/services.dart';

class PrinterManager {
  static final _platform = MethodChannel(PrinterStrings.channel);

  static connect(String mac) async {
    _platform.invokeMethod(
        PrinterStrings.connectCommand, {PrinterStrings.macArg: mac});
  }

  static printImg(String imgPath) async {
    _platform.invokeMethod(
        PrinterStrings.printCommand, {PrinterStrings.imgPathArg: imgPath});
  }
}

class PrinterStrings {
  // channel name
  static String channel = "android.flutter/printer";

  //commands
  static String connectCommand = "printer_connect";
  static String printCommand = "printer_print";

  // arguments
  static String macArg = "printer_mac";
  static String imgPathArg = "img_path";
}
