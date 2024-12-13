//   - name - The name of the property, required.
//   - value - The value of the property, could be null.
//   - meta - Optional field to provide more context, useful for debugging or logging purposes (will not be sent to the analytics service).

sealed class AnalyticsProperty<T extends Object> {
  // The name of this property.
  final String name;

  // The value of this property.
  final T? value;

  // Additional information about this property.
  final Object? meta;

  AnalyticsProperty({
    required this.name,
    required this.value,
    this.meta,
  });

  // Returns the value of this property in a form that is OK for engine.
  //
  // If the value is not serializable, this field should be
  // overridden to return a serializable value.
  Object? get valueSerializable => value;
}

// You may have noticed the valueSerializable getter. It exists to provide some basic
// transformations to objects that are wrapped in these properties. As mentioned in the
// callout before, analytics engines have limitations and it is crucial to have a way to
// standardise these limitations and the properties that can be attached.

final class IntAnalyticsReporter extends AnalyticsProperty<int> {
  IntAnalyticsReporter({
    required super.name,
    required super.value,
    super.meta,
  });
}

final class DoubleAnalyticsReporter extends AnalyticsProperty<double> {
  DoubleAnalyticsReporter({
    required super.name,
    required super.value,
    super.meta,
  });
}

final class StringAnalyticsReporter extends AnalyticsProperty<String> {
  StringAnalyticsReporter({
    required super.name,
    required super.value,
    super.meta,
  });
}

final class FlagAnalyticsProperty extends AnalyticsProperty<bool> {
  FlagAnalyticsProperty({
    required super.name,
    required super.value,
    super.meta,
  });

  @override
  Object? get valueSerializable {
    if (value == null) return null;

    return value! ? 'true' : 'false';
  }
}
