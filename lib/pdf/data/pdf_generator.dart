import 'dart:io';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdfx/pdfx.dart' as ren;

class PdfGenerator {
  static late Font font;
  static late Font boldFont;

  static init() async {
    font =
        Font.ttf((await rootBundle.load("assets/fonts/OpenSans-Regular.ttf")));
    boldFont =
        Font.ttf((await rootBundle.load("assets/fonts/OpenSans-Bold.ttf")));
  }

  static Future<File> generatePdf() async {
    final pdf = Document();

    try {
      pdf.addPage(createPageInvoice());
    } catch (e) {}
    return await saveDocument(name: "my_invoice.pdf", pdf: pdf);
  }

  static Future<Uint8List> generatePdfImage() async {
    final pdf = Document();

    try {
      pdf.addPage(createPageInvoice());
    } catch (e) {}
    return await convertToImage(name: "my_invoice.pdf", pdf: pdf) ??
        Uint8List(1);
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
        theme: ThemeData.withFont(base: font, bold: boldFont),
        build: (context) => Column(children: [
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Аваз Шамс",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17)),
                                SizedBox(height: 20),
                                Text("Таджикистан, Душанбе",
                                    style: const TextStyle(fontSize: 15)),
                                Text("Борбад 76/62",
                                    style: const TextStyle(fontSize: 15)),
                              ]),
                          Text("Накладной",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17)),
                        ]),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Text("Счет к",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10)),
                                SizedBox(height: 10),
                                Text("Джумаев Хафиз",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10)),
                                SizedBox(height: 5),
                                Text("Чинор Чартеппа",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10)),
                                SizedBox(height: 5),
                                Text("Участок Наймано",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10)),
                              ])),
                          SizedBox(width: 10),
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Text("Отправка к",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10)),
                                SizedBox(height: 10),
                                Text("Джумаев Хафиз",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10)),
                                SizedBox(height: 5),
                                Text("Чинор Чартеппа",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10)),
                                SizedBox(height: 5),
                                Text("Участок Наймано",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10)),
                              ])),
                          SizedBox(width: 10),
                          Expanded(
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Expanded(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                      Text("Накладной #",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10)),
                                      SizedBox(height: 10),
                                      Text("Дата ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10)),
                                      SizedBox(height: 5),
                                      Text("Срок оплаты",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10)),
                                    ])),
                                SizedBox(width: 10),
                                Expanded(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                      Text("1001",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11)),
                                      SizedBox(height: 10),
                                      Text("11/02/2019",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10)),
                                      SizedBox(height: 5),
                                      Text("26/02/2019",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10)),
                                    ])),
                              ])),
                          SizedBox(width: 10)
                        ])
                  ])),
              SizedBox(height: 20),
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Table.fromTextArray(
                        border: TableBorder.all(color: PdfColors.grey),
                        headers: [
                          "QTY",
                          "Description",
                          "Unit Price",
                          "Amount"
                        ],
                        data: [
                          [
                            "1",
                            "2",
                            "3",
                          ],
                          [
                            "desc_1",
                            "desc_2",
                            "desc_3",
                          ],
                          ["100", '25', "15"],
                          ["100", '50', '45', '195', '9.75']
                        ],
                        cellAlignments: {
                          0: Alignment.bottomCenter
                        })
                  ])),
              Expanded(child: Container()),
              Expanded(
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Terms and Policy",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 10),
                            Text("Payment is due within 15 days")
                          ])))
            ]));
  }

  static Page createPageInvoice() {
    return Page(
        pageFormat:
            const PdfPageFormat(5.8 * PdfPageFormat.cm, 20 * PdfPageFormat.cm),
        textDirection: TextDirection.rtl,
        theme: ThemeData.withFont(base: font, bold: boldFont),
        build: (context) => Column(children: [Text("Привет всем")]));
  }

  static Future<Uint8List?> convertToImage(
      {required String name, required Document pdf}) async {
    Uint8List bytes = await pdf.save();

    final dir = await getExternalStorageDirectory();
    final file = File("${dir?.path}/$name");

    await file.writeAsBytes(bytes);
    ren.PdfDocument doc = await ren.PdfDocument.openFile(file.path);
    ren.PdfPage page = await doc.getPage(1);

    final ren.PdfPageImage? pageImg = await page.render(
        width: 575, height: page.height + 200, backgroundColor: "#ffffff");

    if (pageImg != null) {
      String path = (await getApplicationDocumentsDirectory()).path;
      File file = File("${path}MY_IMG.png");

      await file.writeAsBytes(pageImg.bytes);
      // OpenFile.open(file.path);
      return pageImg.bytes;
    }
    return null;
  }
}
