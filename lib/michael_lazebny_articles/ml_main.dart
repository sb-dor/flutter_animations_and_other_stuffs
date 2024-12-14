import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_animations_2/michael_lazebny_articles/analytics_reporter/analytics_event.dart';
import 'package:flutter_animations_2/michael_lazebny_articles/analytics_reporter/analytics_reporter.dart';
import 'package:flutter_animations_2/michael_lazebny_articles/error_handling/own_either_class.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'error_handling/mastering_error_handling_in_dart.dart';

void main() {
  final ownEitherClass = MockHttpResponse();

  ownEitherClass.getSomethingFromResponse('');

  final object = MasteringErrorHandlingInDart(
    logger: Logger(),
    client: http.Client(),
  );

  object.exceptionCatcher();

  final AnalyticsReporter analyticsReporter = FirebaseAnalyticsReporter(
    FirebaseAnalytics.instance,
  );

  analyticsReporter.reportEvent(UserLoggedEvent(userId: 1, isPaid: true));
  analyticsReporter.reportEvent(ProductsViewed(id: 10, from: 'main_screen'));
}
