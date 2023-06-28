import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

class PdfGenerator {
  static late Font font;

  static init() async {
    font =
        Font.ttf((await rootBundle.load("assets/fonts/OpenSans-Regular.ttf")));
  }

  static Future<File> generate() async {
    final pdf = Document();

    try {
      pdf.addPage(_createPage());
    } catch (e) {}
    return await saveDocument(name: "my_invoice.pdf", pdf: pdf);
  }

  static Future<File> saveDocument(
      {required String name, required Document pdf}) async {
    Uint8List bytes = await pdf.save();

    final dir = await getExternalStorageDirectory();
    final file = File("${dir?.path}/$name");

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }

  static Page _createPage() {
    return Page(
        textDirection: TextDirection.rtl,
        theme: ThemeData.withFont(base: font),
        build: (context) {
          return Center(child: Container(child: Text("Привет мир!")));
        });
  }
}
