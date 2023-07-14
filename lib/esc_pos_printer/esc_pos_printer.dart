import 'dart:convert';
import 'dart:ui';

// import 'package:charset_converter/charset_converter.dart';
// import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations_2/pdf/data/pdf_generator.dart';
import 'package:image/image.dart' as im;
import 'dart:typed_data';
import 'package:flutter/services.dart';

// import 'package:esc_pos_utils/esc_pos_utils.dart';
// import 'package:windows1251/windows1251.dart';

// import 'dart:convert';
// import 'dart:ui';
//
// import 'package:bluetooth_print/bluetooth_print.dart';
// import 'package:bluetooth_print/bluetooth_print_model.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart' as intl;
//
// class EscPosPrinter {

//
//   static final number = intl.NumberFormat("\$###,###.00", "ru_RU");
//
//   static double total = 0.0;
//
//   static void ini() {
//     total = data.map((e) => e['price'] * e['qty']).reduce((value, element) => value + element);
//   }
//
//   static BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
//
//   static List<BluetoothDevice> devices = [];
//
//   static Future<void> initBlueToothDevices() async {
//     bluetoothPrint.startScan(timeout: const Duration(seconds: 4));
//
//     bluetoothPrint.scanResults.listen((event) {
//       devices = event;
//       debugPrint("devices_length: ${devices.length}");
//     });
//   }
//
//   static String stringAnother(String source) {
//     List<int> list = [];
//     for (var rune in source.runes) {
//       if (rune >= 0x10000) {
//         rune -= 0x10000;
//         int firstWord = (rune >> 10) + 0xD800;
//         list.add(firstWord >> 8);
//         list.add(firstWord & 0xFF);
//         int secondWord = (rune & 0x3FF) + 0xDC00;
//         list.add(secondWord >> 8);
//         list.add(secondWord & 0xFF);
//       } else {
//         list.add(rune >> 8);
//         list.add(rune & 0xFF);
//       }
//     }
//     Uint8List bytes = Uint8List.fromList(list);
//
//     // Here you have `Uint8List` available
//
//     // Bytes to UTF-16 string
//     StringBuffer buffer = StringBuffer();
//     for (int i = 0; i < bytes.length;) {
//       int firstWord = (bytes[i] << 8) + bytes[i + 1];
//       if (0xD800 <= firstWord && firstWord <= 0xDBFF) {
//         int secondWord = (bytes[i + 2] << 8) + bytes[i + 3];
//         buffer.writeCharCode(((firstWord - 0xD800) << 10) + (secondWord - 0xDC00) + 0x10000);
//         i += 4;
//       } else {
//         buffer.writeCharCode(firstWord);
//         i += 2;
//       }
//     }
//
//     // Outcome
//     String outcome = buffer.toString();
//     return '${outcome.length}: "$outcome" (${outcome.runes.length})';
//   }
// }

class EscPosPrinter {
  static List<Map<String, dynamic>> data = [
    {"id": 1, "title": "create new product", "price": 12, "qty": 2},
    {"id": 2, "title": "Шири Душанбеываодлвыоаоывдлаоывдлоадыва", "price": 33, "qty": 5},
    {"id": 3, "title": "Шоколад", "price": 1, "qty": 10.5},
    {"id": 4, "title": "Fanta", "price": 15, "qty": 11},
  ];

  // PrinterBluetoothManager printerBluetoothManager = PrinterBluetoothManager();
  //
  static Future<List<int>> testTicket() async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    List<int> bytes = [];

    // bytes += generator.row([
    //   PosColumn(
    //     text: 'col3',
    //     width: 3,
    //     styles: const PosStyles(align: PosAlign.center, underline: true),
    //   ),
    //   PosColumn(
    //     text: 'col6',
    //     width: 6,
    //     styles: const PosStyles(align: PosAlign.center, underline: true),
    //   ),
    //   PosColumn(
    //     text: 'col3',
    //     width: 3,
    //     styles: const PosStyles(align: PosAlign.center, underline: true),
    //   ),
    // ]);

    String text = "${middleString("Avera")}\n"
        "${rowString(text_2: "Дата: ${DateTime.now().toString().substring(0, 16)}")}\n"
        "${List.filled(40, '-').join()}\n"
        "${rowString(texts: ["N    ", "Наим-ие     ", "Кол-во    ", "Цена     ", "Сум"])}\n"
        "${await createInvoiceDetails(data)}";

    final averaImagesTextBytes = await _generateImageFromString(text, TextAlign.left, fontSize: 20);
    final im.Image? averaTextImage = im.decodeImage(averaImagesTextBytes);

    if (averaTextImage != null) {
      bytes += generator.image(averaTextImage);
    }

    // final averaImagesTextBytes =
    //     await _generateImageFromString("Avera", TextAlign.center, fontSize: 20);
    // final im.Image? averaTextImage = im.decodeImage(averaImagesTextBytes);
    //
    // if (averaTextImage != null) {
    //   bytes += generator.image(averaTextImage);
    // }
    //
    // final dateTimeBytes = await _generateImageFromString(
    //     "Дата: ${DateTime.now().toString().substring(0, 16)}", TextAlign.left,
    //     fontSize: 20);
    //
    // final im.Image? datetimeImage = im.decodeImage(dateTimeBytes);
    // if (datetimeImage != null) {
    //   bytes += generator.image(datetimeImage);
    // }
    //
    // final dashs = await _generateImageFromString((List.filled(29, "-")).join(), TextAlign.center,
    //     fontSize: 20);
    //
    // final im.Image? dashsImage = im.decodeImage(dashs);
    // if (dashsImage != null) {
    //   bytes += generator.image(dashsImage);
    // }
    //
    // final rowNBytes = await _generateImageFromString(
    //     rowString(texts: ["N    ", "Наим-ие     ", "Кол-во    ", "Цена     ", "Сум"]),
    //     TextAlign.left,
    //     fontSize: 20);
    //
    // final im.Image? rowNBytesImage = im.decodeImage(rowNBytes);
    // if (rowNBytesImage != null) {
    //   bytes += generator.image(rowNBytesImage);
    // }
    //
    // for (int i = 0; i < data.length; i++) {
    //   final product = await _generateImageFromString(
    //       rowString(texts: ["${i + 1}    ", "${data[i]["title"]}", '', '', '']),
    //       TextAlign.left);
    //   final im.Image? image = im.decodeImage(product);
    //   if (image != null) {
    //     bytes += generator.image(image);
    //   }
    //   final product_2 = await _generateImageFromString(
    //       rowString(texts: ["", "", '${data[i]['qty']}', '${data[i]['price']}', '']),
    //       TextAlign.left);
    //   final im.Image? image_2 = im.decodeImage(product_2);
    //   if (image_2 != null) {
    //     bytes += generator.image(image_2);
    //   }
    // }
    // final ByteData datas = await rootBundle.load('assets/logo.png');
    final Uint8List imgBytes = await PdfGenerator.generatePdfImage();
    final im.Image? image = im.decodeImage(imgBytes);
    if (image != null) {
      bytes += generator.image(image);
    } // bytes += generator.feed(2);
    // bytes += generator.cut();
    return bytes;
  }

  static Future<Uint8List> _generateImageFromString(String text, TextAlign align,
      {double? fontSize = 20}) async {
    PictureRecorder recorder = PictureRecorder();
    // cheated value, will will clip it later...
    Canvas canvas =
        Canvas(recorder, Rect.fromCenter(center: const Offset(0, 0), width: 550, height: 400));
    TextSpan span = TextSpan(
        style: TextStyle(color: Colors.black, fontSize: fontSize, fontWeight: FontWeight.bold),
        text: text);
    TextPainter tp = TextPainter(text: span, textAlign: align, textDirection: TextDirection.rtl);
    tp.layout(minWidth: 340, maxWidth: 340);
    tp.paint(canvas, const Offset(0.0, 0.0));
    var picture = recorder.endRecording();
    final pngBytes = await picture.toImage(tp.size.width.toInt(), tp.size.height.toInt() - 2);
    final byteData = await pngBytes.toByteData(format: ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  static String rowString({List<String>? texts, String? text_2, int rowSymbolLength = 29}) {
    String str = '';
    if (text_2 != null && text_2.isNotEmpty) {
      debugPrint(
          "${("$text_2${List.filled(rowSymbolLength - (text_2.length + 2), " ").join()}").length}");
      return "$text_2${List.filled(rowSymbolLength - (text_2.length + 2), " ").join()}";
    }
    if (texts != null) {
      for (int i = 0; i < texts.length; i++) {
        debugPrint("each text: ${texts[i]}");
        if (i == 0 && texts[i] == '') {
          str == '     ';
        }
        if (i == 1 && texts[i] == '') {
          str == '     ';
        }
        if (i == 2 && texts[i] == '') {
          str == '     ';
        }
        if (i == 3 && texts[i] == '') {
          str == '     ';
        }
        if (i == 4 && texts[i] == '') {
          str == '     ';
        }
        str += texts[i];
        // if (i != texts.length - 1) str += '  ';
      }
      return str;
    }
    return str;
  }

  static String middleString(String text, {int rowLength = 29}) {
    int middleOfRow = rowLength ~/ 2;
    int middleOfText = text.length ~/ 2;
    String str = "${''.padRight(middleOfRow - middleOfText, ' ')}$text${"".padRight(100, " ")}";
    return str.substring(0, rowLength);
  }

  static Future<String> createInvoiceDetails(List<Map<String, dynamic>> data) async {
    String str = '';

    for (int i = 0; i < data.length; i++) {
      str += "${i + 1}----"
          "${data[i]['title']}"
          '\n';
    }
    return str;
  }
}
