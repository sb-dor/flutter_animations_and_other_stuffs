import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MultiSelectorHelper {
  static ImagePicker imagePicker = ImagePicker();
  static final Dio dio = Dio();

  static Future<Map<String, String>> headers() async {
    return <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      // 'Authorization': 'Bearer ${await SharedPref.getToken()}'
    };
  }

  static Future<List<XFile>> multiImageSelector() async {
    final List<XFile> images = await imagePicker.pickMultiImage();

    if (images.isNotEmpty) {
      return images;
    }
    return [];
  }

  static Future<void> pickMultipleMediaFunc() async {
    //multi image or video together
    await imagePicker.pickMultipleMedia();
  }

  //sendging

  static Future<void> sendImages(List<XFile> images) async {
    List<MultipartFile> multiPartImages = [];

    for (var each in images) {
      multiPartImages.add(await MultipartFile.fromFile(each.path, filename: each.path));
    }

    //sending images with dio package
    var formData = FormData.fromMap({
      'name': 'any_name',
      'second_name': 'any_name',
      "last_name": "any_name",
      //put images that must in array like "field_name[]"
      //and when you getting this field from backend just write "field_name" without brackets
      'images[]': multiPartImages
    });

    // dio.options = BaseOptions(headers: {});
    dio.options = BaseOptions(headers: await headers());
    final response =
        await dio.post("http://192.168.100.113:8000/api/store/multi/image", data: formData);

    if (response.statusCode == 200) {
      debugPrint("${response.data}");
      debugPrint("${response.statusMessage}");
    }
  }
}
