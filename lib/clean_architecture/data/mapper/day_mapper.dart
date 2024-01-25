import 'package:flutter_animations_2/clean_architecture/data/api/models/api_day.dart';
import 'package:flutter_animations_2/clean_architecture/domain/models/day.dart';

class DayMapper {
  static Day fromJson(ApiDay apiDay) {
    return Day(
      sunrise: DateTime.parse(apiDay.sunrise),
      sunset: DateTime.parse(apiDay.sunset),
      solarNoon: DateTime.parse(apiDay.solarNoon),
      dayLength: apiDay.dayLength.toInt(),
    );
  }
}
