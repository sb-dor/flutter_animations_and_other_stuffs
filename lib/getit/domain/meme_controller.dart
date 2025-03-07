import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animations_2/functions/randoms.dart';
import 'package:flutter_animations_2/getit/domain/models/meme_model.dart';
import 'package:flutter_animations_2/getit/presentation/meme_repository.dart';

class MemeDomainController implements MemeRepository {
  @override
  Future<MemeModel> getMeme() async {
    var response = await Dio().get('https://some-random-api.ml/meme');
    Map<String, dynamic> singleMemeJson = jsonDecode(response.data);
    debugPrint("response is : ${response.data}");
    return MemeModel.fromJson(singleMemeJson)..image = Randoms.randomPictureUrl();
  }
}
