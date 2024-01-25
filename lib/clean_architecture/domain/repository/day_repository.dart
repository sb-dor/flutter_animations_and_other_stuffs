import 'package:flutter_animations_2/clean_architecture/domain/models/day.dart';

abstract class DayRepository {
  Future<Day> getDay({required double latitude, required double longitude});
}
