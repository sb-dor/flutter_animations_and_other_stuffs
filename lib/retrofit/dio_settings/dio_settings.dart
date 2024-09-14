import 'package:dio/dio.dart';
import 'package:flutter_animations_2/network/connections.dart';

class DioSettings {
  static final DioSettings _instance = DioSettings._();

  factory DioSettings() {
    return _instance;
  }

  DioSettings._();

  late Dio dio;

  Future<void> initDio() async {
    dio = Dio(
      BaseOptions(
        headers: await Connections.headers(),
      ),
    );
  }
}
