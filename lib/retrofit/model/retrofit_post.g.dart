// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retrofit_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RetrofitPost _$RetrofitPostFromJson(Map<String, dynamic> json) => RetrofitPost(
      userId: (json['userId'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      body: json['body'] as String?,
    );

Map<String, dynamic> _$RetrofitPostToJson(RetrofitPost instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
    };
