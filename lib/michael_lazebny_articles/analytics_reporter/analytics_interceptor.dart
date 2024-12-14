import 'package:flutter/foundation.dart';
import 'package:flutter_animations_2/michael_lazebny_articles/analytics_reporter/analytics_property.dart';
import 'package:logger/logger.dart';

import 'analytics_event.dart';

abstract interface class AnalyticsInterceptor {
  Future<void> report({
    required AnalyticsEvent event,
    required List<AnalyticsProperty> properties,
  });
}

class LoggingAnalyticsInterceptors implements AnalyticsInterceptor {
  final Logger _logger;

  LoggingAnalyticsInterceptors({required Logger logger}) : _logger = logger;

  @override
  Future<void> report({
    required AnalyticsEvent event,
    required List<AnalyticsProperty<Object>> properties,
  }) async {
    if (kDebugMode) {
      _logger.log(Level.debug, "event: ${event.name}");
      for (final each in properties) {
        _logger.log(Level.debug, "${event.name}: ${each.value}");
      }
    }
  }
}
