import 'dart:io';

import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdfx/pdfx.dart' as ren;
import 'package:flutter/material.dart' as matW;
import 'package:url_launcher/url_launcher.dart';

class EscPosPrinterUIHelper {
  static late Font font;
  static late Font boldFont;

  static init() async {
    font = Font.ttf((await rootBundle.load("assets/fonts/OpenSans-Regular.ttf")));
    boldFont = Font.ttf((await rootBundle.load("assets/fonts/OpenSans-Bold.ttf")));
  }

  static List<Map<String, dynamic>> data = [
    {"id": 1, "title": "create new product", "price": 12, "qty": 2},
    {"id": 2, "title": "Шири Душанбе", "price": 33, "qty": 5},
    {"id": 3, "title": "Шоколад", "price": 1, "qty": 10.5},
    {"id": 4, "title": "Fanta", "price": 15, "qty": 11},
  ];

  static Future<String?> createPdf() async {
    String path = (await getApplicationDocumentsDirectory()).path;
    File file = File("${path}MY2_PDF.pdf");

    Document pdf = Document();
    pdf.addPage(_createPage());

    Uint8List bytes = await pdf.save();
    await file.writeAsBytes(bytes);
    // OpenFile.open(file.path);
    final Uri uri = Uri.file(file.absolute.path);
    await launchUrl(uri, mode: LaunchMode.externalApplication,);
    return convertToImage(file.path);
  }

  static Future<String?> convertToImage(String pdfPath) async {
    ren.PdfDocument doc = await ren.PdfDocument.openFile(pdfPath);
    ren.PdfPage page = await doc.getPage(1);

    matW.debugPrint("page width: ${page.width}");
    matW.debugPrint("page height: ${page.height}");
    final ren.PdfPageImage? pageImg =
        await page.render(width: 400, height: page.height + 200, backgroundColor: "#ffffff");

    if (pageImg != null) {
      String path = (await getApplicationDocumentsDirectory()).path;
      File file = File("${path}MY2_IMG.png");

      await file.writeAsBytes(pageImg.bytes);
      // OpenFile.open(file.path);
      return file.path;
    }
    return null;
  }

  //connecting to device function

  static Page _createPage() {
    return Page(
        textDirection: TextDirection.rtl,
        pageFormat: const PdfPageFormat(5.8 * PdfPageFormat.cm, double.infinity,
            marginAll: 0.1 * PdfPageFormat.cm),
        theme: ThemeData.withFont(base: font, bold: boldFont),
        build: (context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(
                  child:
                      Text("Avera", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
              SizedBox(height: 2),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text("Дата: ${DateTime.now().toString().substring(0, 19)}",
                    style: const TextStyle(fontSize: 8))
              ]),
              SizedBox(height: 5),
              Row(children: [
                Text("N", textAlign: TextAlign.left, style: const TextStyle(fontSize: 8)),
                SizedBox(width: 8),
                Expanded(
                    child: Text("Наим-ие",
                        textAlign: TextAlign.center, style: const TextStyle(fontSize: 8))),
                Expanded(
                    child: Text("Кол-во",
                        textAlign: TextAlign.center, style: const TextStyle(fontSize: 8))),
                Expanded(
                    child: Text("Цена",
                        textAlign: TextAlign.center, style: const TextStyle(fontSize: 8))),
                Expanded(
                    child: Text("Сумма",
                        textAlign: TextAlign.center, style: const TextStyle(fontSize: 8))),
              ]),
              Divider(),
              for (int i = 0; i < data.length; i++)
                Column(children: [
                  Row(children: [
                    Text("${i + 1}",
                        textAlign: TextAlign.left, style: const TextStyle(fontSize: 10)),
                    SizedBox(width: 10),
                    Expanded(
                        child: Text("${data[i]['title']}",
                            textAlign: TextAlign.left, style: const TextStyle(fontSize: 10))),
                  ]),
                  SizedBox(height: 3),
                  Row(children: [
                    SizedBox(width: 18),
                    Expanded(child: Container()),
                    Expanded(
                        child: Text("${data[i]['qty']}",
                            textAlign: TextAlign.center, style: const TextStyle(fontSize: 10))),
                    Expanded(
                        child: Text("${data[i]['price']}",
                            textAlign: TextAlign.center, style: const TextStyle(fontSize: 10))),
                    Expanded(
                        child: Text("${data[i]['qty'] * data[i]['price']}",
                            textAlign: TextAlign.center, style: const TextStyle(fontSize: 10))),
                  ]),
                  Divider(color: PdfColors.black, thickness: 2)
                ]),
              Column(children: [
                Row(children: [
                  Expanded(
                      child: Text("Всего",
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                  Expanded(
                      child: Text("10",
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                  SizedBox(width: 10)
                ]),
                Row(children: [
                  Expanded(
                      child: Text("Сумма Скидки -%",
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                  Expanded(
                      child: Text("0",
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                  SizedBox(width: 10)
                ]),
                Divider(color: PdfColors.black, thickness: 2)
              ]),
              Column(children: [
                Row(children: [
                  Expanded(
                      child: Text("Итого к оплате",
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                  Expanded(
                      child: Text("10",
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                  SizedBox(width: 10)
                ]),
                Row(children: [
                  Expanded(
                      child: Text("Наличными",
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                  Expanded(
                      child: Text("0",
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                  SizedBox(width: 10)
                ]),
                Row(children: [
                  Expanded(
                      child: Text("Сдача",
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                  Expanded(
                      child: Text("0",
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                  SizedBox(width: 10)
                ]),
                Divider(color: PdfColors.black, thickness: 2)
              ])
            ]));
  }
}
