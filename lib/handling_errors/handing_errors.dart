import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_animations_2/handling_errors/log_model.dart';
import 'package:flutter_animations_2/hive/lazy_load/hive_settings.dart';
import 'package:rxdart/rxdart.dart';

// you may ask why this kinda logic is necessary :
// because just let's think hypothetically that if the app throws an error or maybe
// the data from server is not compatible for parsing or maybe any error happens in app
// that continues for a while without stopping, then this stream handler will handle all error
// and only after 10 seconds will send data to the server or maybe save in local storage (looking to  the circumstances)
// NOTE: all error will be saved in a list withing 10 seconds and will be sent to the storage
class HandlingErrorsModule {
  static HandlingErrorsModule? _internal;

  static HandlingErrorsModule get internal =>
      _internal ??= HandlingErrorsModule._();

  HandlingErrorsModule._();

  final StreamController<LogModel> _logSteamController =
      StreamController<LogModel>.broadcast();

  void setUpLogging() {
    _logSteamController.stream
        // .map<LogModel>((log) => log)
        .bufferTime(const Duration(seconds: 10))
        .where((log) => log.isNotEmpty)
        .listen(
      (logs) async {
        // debugPrint("saving logs after a while: ${logs.length}");
        await HiveSettings.internal.saveLogs(logs);
      },
    );
  }

  void handlingError() {
    FlutterError.onError = (errorDetails) {
      _logSteamController.add(
        LogModel(
          message: errorDetails.exceptionAsString(),
          timeOfError: DateTime.now().toIso8601String(),
          stack: errorDetails.stack.toString(),
        ),
      );

      // Optionally, print the error to the console
      // FlutterError.dumpErrorToConsole(errorDetails);
    };
  }
}
