import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

class FilePageProvider extends ChangeNotifier {
  //
  void readFile() async {
    // current application documents dir
    pathProvider.getApplicationDocumentsDirectory();

    // downloads path of current app
    final pathOfDownloads = await pathProvider.getDownloadsDirectory();
    print("downloads path: ${pathOfDownloads?.path}");

    // current application cache dir (maybe you are loading the avatars of your friends somewhere,
    // you can save them here in order to not load avatars again
    final tempTemp = await pathProvider.getTemporaryDirectory();
    print("temp path: ${tempTemp.path}");

    // path that is necessary to store and it's persistent and is hidden from user (such as sqlite.db)
    final libraryPath = await pathProvider.getLibraryDirectory();
    print("library path: ${libraryPath.path}");
  }

  //

  void downloadImageIntoDownloads() async {
    final url = "https://img.stablecog.com/insecure/256w/aHR0cHM6Ly"
        "9iLnN0YWJsZWNvZy5jb20vNDcyMzljYzgtZTg5OS00ZjljLWEwNjktOWRkOTRmODBkNTA3LmpwZWc.webp";

    final response = await Dio().get<List<int>>(
      url,
      options: Options(
        responseType: ResponseType.bytes,
      ),
    );

    final downloadsPath = await pathProvider.getDownloadsDirectory();

    File downloadFile = File("${downloadsPath?.path}/dartfile.jpeg");

    if (!downloadFile.existsSync()) downloadFile.createSync(recursive: true);

    print(downloadsPath?.path);

    downloadFile.writeAsBytesSync(response.data ?? <int>[]);
  }

  List<File> files = [];

  void getFiles() async {
    final downloadsPath = await pathProvider.getDownloadsDirectory();


    // recursive : true | means that if this directory has another directory (folder) it will return files or folders of that folder too
    // https://youtu.be/21o4tS7a2-U?list=PLrnbjo4fMQwYxZMrbyweTFaOTmMbZEx1z&t=2533
    files = downloadsPath?.listSync(recursive: true).map((e) => File(e.path)).toList() ?? [];

    notifyListeners();
  }
}
