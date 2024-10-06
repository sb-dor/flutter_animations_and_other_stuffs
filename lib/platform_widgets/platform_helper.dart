import 'package:flutter/foundation.dart';

abstract final class PlatformHelper {
  static bool isCupertino() {
    return defaultTargetPlatform == TargetPlatform.macOS ||
            defaultTargetPlatform == TargetPlatform.iOS
        ? true
        : false;
  }
}
