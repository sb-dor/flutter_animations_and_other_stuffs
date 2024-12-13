import 'package:flutter_animations_2/michael_lazebny_articles/analytics_reporter/analytics_property.dart';

final class AnalyticsBuilder {
  AnalyticsBuilder() : properties = const [];

  final List<AnalyticsProperty> properties;

  void add(AnalyticsProperty property) => properties.add(property);

  /// Returns the properties as a map.
  ///
  /// This method should be called after all properties have been added.
  Map<String, Object?> toMap() {
    final result = <String, Object?>{};
    for (final each in properties) {
      result[each.name] = each.valueSerializable;
    }
    return result;
  }
}
