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

  static Future<void> saveImageWithDio() async {
    try {
      var imageUrl =
          'https://dcblog.b-cdn.net/wp-content/uploads/2021/02/Full-form-of-URL-1-1024x824.jpg';
      //getting image from url address in bytes List<int>
      var dioRes = await Dio().get<List<int>>(imageUrl,
          options: Options(
              responseType: ResponseType.bytes, headers: await headers()));

      //it is download directory (in android)
      var downloadDirectory = Directory('/storage/emulated/0/Download');

      //creates path if this path is not exist
      String createPath = downloadDirectory.path;
      await Directory(createPath).create(recursive: true);

      //create this image with any name in this path
      var createImageInPath = '${downloadDirectory.path}/any_image_name.jpg';

      File file = File(createImageInPath);

      file.writeAsBytesSync(dioRes.data!);

      print("file path ${file.path}");
    } catch (e) {
      debugPrint("error id :$e");
    }
  }

  static Future<void> createImageInAppStorageWithHttp() async {
    try {
      //getting image from url address
      var res = await http.get(
          Uri.parse(
              "https://dcblog.b-cdn.net/wp-content/uploads/2021/02/Full-form-of-URL-1-1024x824.jpg"),
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
      var res = await http.get(
          Uri.parse(
              "https://dcblog.b-cdn.net/wp-content/uploads/2021/02/Full-form-of-URL-1-1024x824.jpg"),
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
