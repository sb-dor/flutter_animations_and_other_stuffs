import 'package:flutter_animations_2/michael_lazebny_articles/analytics_reporter/analytics_property.dart';

import 'analytics_builder.dart';

abstract interface class AnalyticsEvent {
  String get name;

  void buildProperties(AnalyticsBuilder builder);
}

//
//
final class ProductsViewed extends AnalyticsEvent {
  final int id;
  final String from;

  ProductsViewed({
    required this.id,
    required this.from,
  });

  @override
  String get name => 'products_viewed';

  @override
  void buildProperties(AnalyticsBuilder builder) {
    builder.add(IntAnalyticsReporter(name: 'product_id', value: id));
    builder.add(StringAnalyticsReporter(name: 'from', value: from));
  }
}

//

final class UserLoggedEvent extends AnalyticsEvent {
  final int userId;
  final bool isPaid;

  UserLoggedEvent({
    required this.userId,
    required this.isPaid,
  });

  @override
  String get name => "user_logged";

  @override
  void buildProperties(AnalyticsBuilder builder) {
    builder.add(IntAnalyticsReporter(name: "user_id", value: userId));
    builder.add(FlagAnalyticsProperty(name: "is_paid", value: isPaid));
  }
}
