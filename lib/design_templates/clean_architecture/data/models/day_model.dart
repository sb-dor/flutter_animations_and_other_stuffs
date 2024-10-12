import 'package:flutter_animations_2/design_templates/clean_architecture/domain/entities/day.dart';

class DayModel extends Day {
  DayModel(
    DateTime? sunrise,
    DateTime? sunset,
    DateTime? solarNoon,
    int? dayLength,
  ) : super(
          sunrise: sunrise,
          sunset: sunset,
          solarNoon: solarNoon,
          dayLength: dayLength,
        );

  factory DayModel.fromJson(Map<String, dynamic> map) {
    return DayModel(
      DateTime.tryParse("${map['results']['sunrise']}"),
      DateTime.tryParse("${map['results']['sunset']}"),
      DateTime.tryParse("${map['results']['solar_noon']}"),
      int.tryParse("${map['results']['day_length']}"),
    );
  }

  static DayModel? fromEntity(Day? day) {
    if (day == null) return null;
    return DayModel(
      day.sunrise,
      day.sunset,
      day.solarNoon,
      day.dayLength,
    );
  }
}
