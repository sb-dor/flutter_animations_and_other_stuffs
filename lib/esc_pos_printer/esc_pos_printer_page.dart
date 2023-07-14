// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:flutter/services.dart';
// import 'package:image/image.dart' as im;
// import 'package:bluetooth_print/bluetooth_print.dart';
// import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'dart:typed_data';

// import 'package:charset_converter/charset_converter.dart';
// import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations_2/esc_pos_printer/esc_pos_printer.dart';

// import 'package:flutter_animations_2/esc_pos_printer/esc_pos_printer.dart';

// import 'package:flutter_animations_2/esc_pos_printer/esc_pos_printer.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// class EscPosPrinterPage extends StatefulWidget {
//   const EscPosPrinterPage({Key? key}) : super(key: key);
//
//   @override
//   State<EscPosPrinterPage> createState() => _EscPosPrinterPageState();
// }
//
// class _EscPosPrinterPageState extends State<EscPosPrinterPage> {
//   BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//     //   EscPosPrinter.ini();
//     //   EscPosPrinter.initBlueToothDevices();
//     // });
//     getDevices();
//   }
//
//   List<BluetoothDevice> devices = [];
//
//   BluetoothDevice? selectedDevice;
//
//   void getDevices() async {
//     await bluetoothPrint.startScan(timeout: const Duration(seconds: 4));
//
//     bluetoothPrint.scanResults.listen((event) {
//       devices = event;
//       setState(() {});
//     });
//     debugPrint("devices_length_page: ${devices.length}");
//     bluetoothPrint.stopScan();
//     setState(() {});
//   }
//
//   Future<void> _startPrint() async {
//     Map<String, dynamic> config = {};
//     List<LineText> list = [];
//
//     try {
//       const String letters = 'Привет';
//       final im.Image image = im.Image(100, 100); // Create a blank image
//       final im.BitmapFont font = im.arial_48; // Choose a font and size
//
//       im.drawString(image, font, 10, 10, letters); // Draw the letters on the image
//
//       final List<int> bytes = im.encodePng(image);
//       // ByteData data = await rootBundle.load("assets/images/burger.png");
//       // List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
//       String base64Image = base64Encode(bytes);
//
//       list.add(LineText(
//           type: LineText.TYPE_TEXT,
//           content: "Avera",
//           weight: 3,
//           width: 2,
//           height: 2,
//           align: LineText.ALIGN_CENTER,
//           linefeed: 1));
//
//       list.add(LineText(
//           type: LineText.TYPE_IMAGE,
//           content: base64Image,
//           align: LineText.ALIGN_CENTER,
//           linefeed: 1));
//
//       for (var i = 0; i < EscPosPrinter.data.length; i++) {
//         list.add(LineText(
//             type: LineText.TYPE_TEXT,
//             content: EscPosPrinter.data[i]['title'],
//             weight: 0,
//             align: LineText.ALIGN_LEFT,
//             linefeed: 1));
//       }
//       list.add(LineText(linefeed: 1));
//       list.add(LineText(linefeed: 1));
//       list.add(LineText(linefeed: 1));
//       list.add(LineText(linefeed: 1));
//
//       await bluetoothPrint.printReceipt(config, list);
//     } catch (e) {
//       debugPrint("ERROR IS: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Flutter - thermal printe вввr"), backgroundColor: Colors.red),
//       body: SizedBox(
//         width: double.maxFinite,
//         child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
//           TextButton(
//               onPressed: () => _startPrint(), child: Text("Print", style: TextStyle(fontSize: 20))),
//           if (selectedDevice != null) Text("Selected - device: ${selectedDevice?.name}"),
//           SizedBox(height: 20),
//           Expanded(
//               child: RefreshIndicator(
//             onRefresh: () async => getDevices(),
//             child: ListView.separated(
//                 separatorBuilder: (context, index) => const Divider(),
//                 itemCount: devices.length,
//                 itemBuilder: (context, index) {
//                   return InkWell(
//                     onTap: () async {
//                       await bluetoothPrint.connect(devices[index]);
//                       setState(() {
//                         selectedDevice = devices[index];
//                       });
//                     },
//                     child: Column(children: [
//                       Text("Printer: ${devices[index].name}",
//                           style: TextStyle(color: Colors.black)),
//                       Text("address: ${devices[index].address}"),
//                     ]),
//                   );
//                 }),
//           ))
//         ]),
//       ),
//     );
//   }
// }

class EscPosPrinterPage extends StatefulWidget {
  const EscPosPrinterPage({Key? key}) : super(key: key);

  @override
  State<EscPosPrinterPage> createState() => _EscPosPrinterPageState();
}

class _EscPosPrinterPageState extends State<EscPosPrinterPage> {
  PrinterBluetoothManager printerManager = PrinterBluetoothManager();

  List<PrinterBluetooth> printerDevices = [];
  PrinterBluetooth? selected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkDevices();
  }

  void checkDevices() async {
    printerManager.startScan(const Duration(seconds: 4));

    printerManager.scanResults.listen((printers) async {
      printerDevices = printers;
      setState(() {});
    });

    debugPrint("length of devices: ${printerDevices.length}");
  }

  void print() async {
    try {
      await printerManager.printTicket(await EscPosPrinter.testTicket());
    } catch (e) {
      debugPrint("error exception: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter printer"), backgroundColor: Colors.red),
      body: Container(
          width: double.maxFinite,
          child: Column(children: [
            SizedBox(height: 10),
            IconButton(
                onPressed: () {
                  debugPrint(
                    "Avera\n"
                    "Дата: ${DateTime.now().toString().substring(0, 16)}\n"
                    // "${List.filled(30, '-').join()}\n"
                    "${EscPosPrinter.rowString(texts: [
                          "N    ",
                          "Наим-ие     ",
                          "Кол-во    ",
                          "Цена     ",
                          "Сум"
                        ])}\n"
                    "1    машина\n",
                  );
                  print();
                },
                icon: Icon(Icons.print)),
            if (selected != null) Text("${selected?.name}"),
            Expanded(
                child: RefreshIndicator(
              onRefresh: () async => checkDevices(),
              child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: printerDevices.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          printerManager.selectPrinter(printerDevices[index]);
                          setState(() {
                            selected = printerDevices[index];
                          });
                        },
                        child: Column(children: [
                          Text("Printer name: ${printerDevices[index].name}"),
                          Text("Address: ${printerDevices[index].address}"),
                        ]));
                  }),
            ))
          ])),
    );
  }
}
