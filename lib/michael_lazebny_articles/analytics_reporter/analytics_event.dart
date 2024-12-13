import 'package:flutter_animations_2/michael_lazebny_articles/analytics_reporter/analytics_property.dart';

import 'analytics_builder.dart';

abstract interface class AnalyticsEvent {
  String get name;

  void buildProperties(AnalyticsBuilder builder);
}

//
//
final class ProductsViewed extends AnalyticsEvent {
  final String id;
  final String from;

  ProductsViewed({
    required this.id,
    required this.from,
  });

  @override
  String get name => 'products_viewed';

  @override
  void buildProperties(builder) {
    builder.add(StringAnalyticsReporter(name: 'product_id', value: id));
    builder.add(StringAnalyticsReporter(name: 'from', value: from));
  }
}
