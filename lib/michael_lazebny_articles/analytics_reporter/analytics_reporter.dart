import 'package:flutter_animations_2/michael_lazebny_articles/analytics_reporter/analytics_builder.dart';
import 'package:flutter_animations_2/michael_lazebny_articles/analytics_reporter/analytics_event.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_animations_2/michael_lazebny_articles/analytics_reporter/analytics_interceptor.dart';

abstract base class AnalyticsReporter {
  final List<AnalyticsInterceptor> _interceptors;

  AnalyticsReporter(
      {List<AnalyticsInterceptor> interceptors =
          const <AnalyticsInterceptor>[]})
      : _interceptors = interceptors;

  // write interceptors then.

  Future<void> reportEvent(AnalyticsEvent event) async {
    final builder = AnalyticsBuilder();

    event.buildProperties(builder);

    await _reportEvent(event.name, builder.toMap());

    for (final each in _interceptors) {
      await each.report(event: event, properties: builder.properties);
    }
  }

  Future<void> _reportEvent(String name, Map<String, Object> properties);
}

//
//
final class FirebaseAnalyticsReporter extends AnalyticsReporter {
  final FirebaseAnalytics _analytics;

  FirebaseAnalyticsReporter(this._analytics, {super.interceptors});

  @override
  Future<void> _reportEvent(String name, Map<String, Object> properties) async {
    await _analytics.logEvent(
      name: name,
      parameters: properties,
    );
  }
}
