class ApiDay {
  final String sunrise;
  final String sunset;
  final String solarNoon;
  final num dayLength;

  ApiDay.fromJson(Map<String, dynamic> map)
      : sunrise = map['results']['sunrise'],
        sunset = map['results']['sunset'],
        solarNoon = map['results']['solar_noon'],
        dayLength = map['results']['day_length'];
}
