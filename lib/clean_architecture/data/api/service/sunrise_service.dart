import 'package:dio/dio.dart';
import 'package:flutter_animations_2/clean_architecture/data/api/models/api_day.dart';

class SunriseService {
  static const String _baseUrl = "https://api.sunrise-sunset.org";

  final Dio _dio = Dio(
    BaseOptions(baseUrl: _baseUrl),
  );

  Future<ApiDay> getDay({required double lat, required double lng}) async {
    final query = {
      "lat": lat,
      "lng": lng,
      'formatted': 0,
    };

    final response = await _dio.get(
      '/json',
      queryParameters: query,
    );
    return ApiDay.fromJson(response.data);
  }
}
