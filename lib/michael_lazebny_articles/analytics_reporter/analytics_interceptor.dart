import 'package:flutter/foundation.dart';
import 'package:flutter_animations_2/michael_lazebny_articles/analytics_reporter/analytics_property.dart';

import 'analytics_event.dart';

abstract interface class AnalyticsInterceptor {
  Future<void> report({
    required AnalyticsEvent event,
    required List<AnalyticsProperty> properties,
  });
}

class LoggingAnalyticsInterceptors implements AnalyticsInterceptor {
  @override
  Future<void> report({
    required AnalyticsEvent event,
    required List<AnalyticsProperty<Object>> properties,
  }) async {
    if (kDebugMode) {
      debugPrint("event: ${event.name}");
      for (final each in properties) {
        debugPrint("${event.name}: ${each.value}");
      }
    }
  }
}
