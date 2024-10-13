import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

class FilePageProvider extends ChangeNotifier {
  //
  void readFile() async {
    // current application documents dir
    pathProvider.getApplicationDocumentsDirectory();

    // downloads path
    final pathOfDownloads = await pathProvider.getDownloadsDirectory();
    print("downloads path: ${pathOfDownloads?.path}");

    // current application cache dir (maybe you are loading the avatars of your friends somewhere,
    // you can save them here in order to not load avatars again
    final tempTemp = await pathProvider.getTemporaryDirectory();
  }
  //
}
