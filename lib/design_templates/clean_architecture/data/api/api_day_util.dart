import 'package:flutter_animations_2/design_templates/clean_architecture/data/mapper/day_mapper.dart';
import 'package:flutter_animations_2/design_templates/clean_architecture/data/models/day_model.dart';
import 'package:flutter_animations_2/design_templates/clean_architecture/domain/entities/day.dart';

import 'service/sunrise_service.dart';

class ApiDatUtil {
  final SunriseService _sunriseService = SunriseService();

  Future<DayModel> getDay({
    required double latitude,
    required double longitude,
  }) async {
    final result = await _sunriseService.getDay(lat: latitude, lng: longitude);
    return result;
  }
}
