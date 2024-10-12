import 'package:dio/dio.dart';
import 'package:flutter_animations_2/design_templates/clean_architecture/data/models/day_model.dart';

import '../models/api_day.dart';

class SunriseService {
  static const String _baseUrl = "https://api.sunrise-sunset.org";

  final Dio _dio = Dio(
    BaseOptions(baseUrl: _baseUrl),
  );

  Future<DayModel> getDay({required double lat, required double lng}) async {
    final query = {
      "lat": lat,
      "lng": lng,
      'formatted': 0,
    };

    final response = await _dio.get(
      '/json',
      queryParameters: query,
    );
    return DayModel.fromJson(response.data);
  }
}
