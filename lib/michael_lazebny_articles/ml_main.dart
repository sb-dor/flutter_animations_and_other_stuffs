import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations_2/michael_lazebny_articles/analytics_reporter/analytics_event.dart';
import 'package:flutter_animations_2/michael_lazebny_articles/analytics_reporter/analytics_interceptor.dart';
import 'package:flutter_animations_2/michael_lazebny_articles/analytics_reporter/analytics_reporter.dart';
import 'package:flutter_animations_2/michael_lazebny_articles/error_handling/own_either_class.dart';
import 'package:flutter_animations_2/michael_lazebny_articles/popups/popup_widgets.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'error_handling/mastering_error_handling_in_dart.dart';
import 'popups/custom_dropdown.dart';
import 'popups/custom_tool_tip_impl.dart';
import 'popups/popup_follower_impl.dart';
import 'popups/popup_widgets_with_shortcuts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _appRunner();
  return;
  final ownEitherClass = MockHttpResponse();

  ownEitherClass.getSomethingFromResponse('');

  final object = MasteringErrorHandlingInDart(
    logger: Logger(),
    client: http.Client(),
  );

  object.exceptionCatcher();

  final Logger logger = Logger();

  final AnalyticsReporter analyticsReporter = FirebaseAnalyticsReporter(
    FirebaseAnalytics.instance,
    interceptors: [
      LoggingAnalyticsInterceptors(logger: logger),
    ],
  );

  analyticsReporter.reportEvent(UserLoggedEvent(userId: 1, isPaid: true));
  analyticsReporter.reportEvent(ProductsViewed(id: 10, from: 'main_screen'));
}

void _appRunner() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        // showSemanticsDebugger: true,
        home: CustomToolTipImpl(),
      ),
    );
