// import 'package:flutter/material.dart';
// import 'package:flutter_animations_2/esc_pos_printer_with_bluetooth/printer_manager.dart';
// import 'package:flutter_scan_bluetooth/flutter_scan_bluetooth.dart';
//
// class EscPosPrinterPage extends StatefulWidget {
//   const EscPosPrinterPage({Key? key}) : super(key: key);
//
//   @override
//   State<EscPosPrinterPage> createState() => _EscPosPrinterPageState();
// }
//
// class _EscPosPrinterPageState extends State<EscPosPrinterPage> {
//   FlutterScanBluetooth flutterScanBluetooth = FlutterScanBluetooth();
//   List<BluetoothDevice> devices = [];
//   BluetoothDevice? selectedDevice;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   void scanDevices() async {
//     await flutterScanBluetooth.startScan();
//
//     flutterScanBluetooth.devices.listen((device) {
//       if (!checkIsDeviceAlreadyAdded(device)) {
//         setState(() {
//           devices.add(device);
//         });
//       }
//     });
//
//     await Future.delayed(const Duration(seconds: 5));
//     flutterScanBluetooth.stopScan();
//   }
//
//   bool checkIsDeviceAlreadyAdded(BluetoothDevice device) =>
//       devices.any((element) => element.address == device.address);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: const Text("Flutter Esc Pos Printer"), backgroundColor: Colors.red),
//         body: Column(children: [
//           TextButton(
//               onPressed: () async {
//                 // if (selectedDevice == null) return;
//                 // var image = await EscPosPrinterUIHelper.createPdf() ?? '';
//                 // if (image.isEmpty) return;
//                 // await PrinterManager.printImg(image);
//               },
//               child: const Text("Start print")),
//           if (selectedDevice != null)
//             Column(children: [
//               const SizedBox(height: 10),
//               Text("Selected Device: ${selectedDevice?.name}"),
//               const SizedBox(height: 10)
//             ]),
//           Expanded(
//               child: RefreshIndicator(
//                   onRefresh: () async => scanDevices(),
//                   child: ListView.separated(
//                       separatorBuilder: (context, index) => const Divider(),
//                       itemCount: devices.length,
//                       itemBuilder: (context, index) => InkWell(
//                           onTap: () {
//                             PrinterManager.connect(devices[index].address);
//                             setState(() {
//                               selectedDevice = devices[index];
//                             });
//                           },
//                           child: Container(
//                               padding: const EdgeInsets.all(10),
//                               child: Column(children: [
//                                 Text("Name: ${devices[index].name}"),
//                                 Text("Address: ${devices[index].address}")
//                               ]))))))
//         ]));
//   }
// }
