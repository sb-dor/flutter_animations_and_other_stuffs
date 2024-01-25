import 'package:flutter_animations_2/clean_architecture/data/api/api_day_util.dart';
import 'package:flutter_animations_2/clean_architecture/domain/models/day.dart';
import 'package:flutter_animations_2/clean_architecture/domain/repository/day_repository.dart';

class DayDataRepository extends DayRepository {
  final ApiDatUtil _apiDatUtil = ApiDatUtil();

  @override
  Future<Day> getDay({required double latitude, required double longitude}) =>
      _apiDatUtil.getDay(latitude: latitude, longitude: longitude);
}
