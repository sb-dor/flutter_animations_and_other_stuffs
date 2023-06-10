import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class Connections {
  static const String url = 'http://192.168.100.113:8000/api';

  static Future<Map<String, String>> headers() async {
    return <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer '
    };
  }

  static final dio = Dio();

  static Future<void> checkDio() async {
    try {
      var res = await dio.post("$url/validation",
          data: jsonEncode({"email": "avaz@gmail.com", 'name': "avaz"}),
          options: Options(headers: await headers()));

      debugPrint("message: ${res.data}");
      if (res.statusCode == 200) {}
    } catch (e) {
      debugPrint("$e");
    }
  }

  static Future<void> createImageInAppStorageWithHttp() async {
    try {
      //getting image from url address
      var res = await http.get(Uri.parse("$url/temp/image"),
          headers: await headers());

      //it is application only directory
      var ourDirectory = await getApplicationDocumentsDirectory();

      //creates path if this path is not exist
      String createPathInDirectory = '${ourDirectory.path}/images';
      await Directory(createPathInDirectory).create(recursive: true);

      //create this image with any name in this path
      var createImageNameInPath =
          '${ourDirectory.path}/images/any_image_name.jpg';

      File file = File(createImageNameInPath);

      file.writeAsBytesSync(res.bodyBytes);

      print("file path ${file.path}");
    } catch (e) {
      debugPrint("$e");
    }
  }

  static Future<void> createImageInPhoneStorageWithHttp() async {
    try {
      //getting image from url address
      var res = await http.get(Uri.parse("$url/temp/image"),
          headers: await headers());

      //it is phone storage directory
      var ourDirectory = await getExternalStorageDirectory();

      //create this image with any name in this path
      var createImageNameInPath = '${ourDirectory?.path}/any_image_name.jpg';

      //then save file like this code below
      File file = File(createImageNameInPath);

      file.writeAsBytesSync(res.bodyBytes);

      print("file path ${file.path}");
    } catch (e) {
      debugPrint("$e");
    }
  }

  static Future<void> checkHttp() async {
    try {
      var res = await http.post(Uri.parse("$url/validation"),
          body: jsonEncode({"email": "avaz@gmail.com", 'name': "avaz"}),
          headers: await headers());

      debugPrint("message: ${res.body}");
      if (res.statusCode == 200) {}
    } catch (e) {
      debugPrint("$e");
    }
  }
}
