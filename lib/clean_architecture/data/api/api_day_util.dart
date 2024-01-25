import 'package:flutter_animations_2/clean_architecture/data/api/service/sunrise_service.dart';
import 'package:flutter_animations_2/clean_architecture/data/mapper/day_mapper.dart';
import 'package:flutter_animations_2/clean_architecture/domain/models/day.dart';

class ApiDatUtil {
  final SunriseService _sunriseService = SunriseService();

  Future<Day> getDay({
    required double latitude,
    required double longitude,
  }) async {
    final result = await _sunriseService.getDay(lat: latitude, lng: longitude);
    return DayMapper.fromJson(result);
  }
}
