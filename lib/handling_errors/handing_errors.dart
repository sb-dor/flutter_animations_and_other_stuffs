import 'dart:async';
import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_animations_2/handling_errors/log_model.dart';
import 'package:flutter_animations_2/hive/lazy_load/hive_settings.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rxdart/rxdart.dart';

// it's necessary now, after using Hive I do not use this module any more
class SecureStorageHelper {
  static SecureStorageHelper? _internal;

  static SecureStorageHelper get internal => _internal ??= SecureStorageHelper._();

  SecureStorageHelper._();

  // not usable now
  late final FlutterSecureStorage _storage;

  Future<void> init() async {
    const androidOptions = AndroidOptions(
      encryptedSharedPreferences: true,
      keyCipherAlgorithm: KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding,
    );
    const iosOptions = IOSOptions(
      accessibility: KeychainAccessibility.first_unlock, // When the data is accessible
      synchronizable: true, // Sync data with iCloud
    );

    /// * If `useBackwardCompatibility` is set to `true`, trying to read from values
    ///   which were written by previous versions. In addition, when reading or
    ///   writing from previpus version's storage, read values will be migrated to
    ///   new storage automatically. This may introduces some performance hit and
    ///   might cause error for some kinds of keys.
    ///   Default is `false`.
    ///   You must set this value to `false` if you could use:
    ///   * Keys containing `"`, `<`, `>`, `|`, `:`, `*`, `?`, `/`, `\`,
    ///     or any of ASCII control charactors.
    ///   * Keys containing `/../`, `\..\`, or their combinations.
    ///   * Long key string (precise size is depends on your app's product name,
    ///     company name, and account name who executes your app).
    ///
    /// You can migrate all old data with this options as following:
    /// ```dart
    /// await FlutterSecureStorage().readAll(
    ///     const WindowsOptions(useBackwardCompatibility: true),
    /// );
    /// ```
    const windowsOptions = WindowsOptions(
      useBackwardCompatibility:
          true, // Stores data in a protected folder within the user's directory
    );

    const macosOptions = MacOsOptions(
      accessibility: KeychainAccessibility.first_unlock, // Matches iOS accessibility
      synchronizable: true, // Sync with iCloud if needed
    );

    // it automatically will be set even if you don't set the value
    const linuxOptions = LinuxOptions();

    // it automatically will be set even if you don't set the value
    const webOptions = WebOptions();

    _storage = const FlutterSecureStorage(
      aOptions: androidOptions,
      iOptions: iosOptions,
      mOptions: macosOptions,
      wOptions: windowsOptions,
      lOptions: linuxOptions,
      webOptions: webOptions,
    );
  }
}

class HandlingErrorsModule {
  // final _secureStorage = SecureStorageHelper.internal;
  static HandlingErrorsModule? _internal;

  static HandlingErrorsModule get internal => _internal ??= HandlingErrorsModule._();

  HandlingErrorsModule._();

  final StreamController<LogModel> _logSteamController = StreamController<LogModel>.broadcast();

  void setUpLogging() {
    _logSteamController.stream
        .map<LogModel>(
          (log) {
            return LogModel(
              message: log.message,
              timeOfError: log.timeOfError,
              stack: log.stack,
            );
          },
        )
        .bufferTime(const Duration(seconds: 10))
        .where((log) => log.isNotEmpty)
        .listen(
          (logs) async {
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

  int numberForMocks = 0;

  void mockErrors() {
    numberForMocks = 0; // Reset the counter each time you start mocking

    void throwMockError() {
      try {
        // This will throw a FormatException
        int.parse("fake");
      } catch (error, stackTrace) {
        FlutterError.reportError(FlutterErrorDetails(
          exception: error,
          stack: stackTrace,
        ));

        numberForMocks++;
        if (numberForMocks < 100) {
          Future.delayed(
              Duration.zero, throwMockError); // Avoid stack overflow by scheduling the next call
        }
      }
    }

    throwMockError();
  }
}
