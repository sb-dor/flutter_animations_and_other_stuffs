import 'package:dio/dio.dart';
import 'package:flutter_animations_2/network/connections.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

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
        baseUrl: 'https://jsonplaceholder.typicode.com',
        headers: await Connections.headers(),
      ),
    );
    dio.interceptors.add(PrettyDioLogger());
  }
}
