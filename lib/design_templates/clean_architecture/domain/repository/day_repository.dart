import 'package:flutter_animations_2/design_templates/clean_architecture/domain/entities/day.dart';

abstract class DayRepository {
  Future<Day> getDay({
    required double latitude,
    required double longitude,
  });
}
