import 'package:dio/dio.dart';
import 'package:flutter_animations_2/retrofit/model/retrofit_post.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'retrofit_post_api_service.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com')
abstract class RetrofitPostApiService {
  factory RetrofitPostApiService(Dio dio) = _RetrofitPostApiService;

  @GET('/posts')
  Future<List<RetrofitPost>> getPosts();
}
