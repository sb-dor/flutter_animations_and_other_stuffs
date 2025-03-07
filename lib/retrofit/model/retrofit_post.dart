import 'package:freezed_annotation/freezed_annotation.dart';

part 'retrofit_post.g.dart';

@JsonSerializable()
class RetrofitPost {
  final int? userId;
  final int? id;
  final String? title;
  final String? body;

  RetrofitPost({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory RetrofitPost.fromJson(Map<String, dynamic> json) =>
      _$RetrofitPostFromJson(json);

  Map<String, dynamic> toJson() => _$RetrofitPostToJson(this);
}
