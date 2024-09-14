import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_animations_2/retrofit/model/retrofit_post.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'retrofit_post_api_service.g.dart';

// if in the future you will have the data that returns something
// you better create a class that handles that data for ex:

@immutable
class DataFromServer {
  final bool? success;
  final String? message;

  const DataFromServer({this.success, this.message});

  // you can use JsonSerializable
  factory DataFromServer.fromJson(Map<String, dynamic> json) {
    return DataFromServer(
      success: json['success'],
      message: json['message'],
    );
  }
}

@RestApi(baseUrl: '/posts')
abstract class RetrofitPostApiService {
  factory RetrofitPostApiService(Dio dio) = _RetrofitPostApiService;

  @GET('') // will get the main baseUrl
  Future<List<RetrofitPost>> getPosts();

  @DELETE("/{id}")
  Future<void> delete(@Path('id') int? id);

  @POST('') // will get the main baseUrl
  Future<void> post(@Body() RetrofitPost post);

  // not necessary request
  @GET('')
  Future<DataFromServer> dataFromServer();
}
