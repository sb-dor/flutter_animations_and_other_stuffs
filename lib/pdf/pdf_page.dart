import 'package:flutter/material.dart';
import 'package:flutter_animations_2/pdf/data/pdf_generator.dart';

class PdfPage extends StatefulWidget {
  const PdfPage({super.key});

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  // final FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  // BluetoothDevice? selectedDevice;
  // List<ScanResult> devices = [];

  // void scan() async {
  //   await flutterBlue.startScan(timeout: const Duration(seconds: 4));
  //
  //   flutterBlue.scanResults.listen((event) {
  //     devices = event;
  //     setState(() {});
  //   });
  //   debugPrint("devices length: ${devices.length}");
  //
  //   await flutterBlue.stopScan();
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // scan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter printing")),
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () async {
                    final pdf = await PdfGenerator.generatePdf();

                    await PdfGenerator.openFile(pdf);
                    // await Printing.layoutPdf(
                    //     format: const PdfPageFormat(5.8 * PdfPageFormat.cm, 20 * PdfPageFormat.cm),
                    //     onLayout: (PdfPageFormat format) async {
                    //       final pdf = pdfWidgets.Document();
                    //       pdf.addPage(pdfWidgets.Page(
                    //           pageFormat: const PdfPageFormat(
                    //               5.8 * PdfPageFormat.cm, 20 * PdfPageFormat.cm),
                    //           textDirection: pdfWidgets.TextDirection.rtl,
                    //           theme: pdfWidgets.ThemeData.withFont(
                    //               base: PdfGenerator.font, bold: PdfGenerator.boldFont),
                    //           build: (context) =>
                    //               pdfWidgets.Column(children: [pdfWidgets.Text("Привет всем")])));
                    //       return pdf.save();
                    //     });
                    // for(var each in await Printing.listPrinters()){
                    //   debugPrint("Name: ${each.name}");
                    //   debugPrint("Url: ${each.url}");
                    // }
                    // return;
                    // if (selectedDevice == null) return;
                    // debugPrint("direct print pdf");
                    // debugPrint("printer id: ${selectedDevice!.id.id}");
                    // debugPrint("bluetooth type: ${selectedDevice!.type.name}");

                    // FlutterBluetoothPrinter.printImage(address: selectedDevice!.id.id,
                    //     imageBytes:,
                    //     imageWidth: imageWidth,
                    //     imageHeight: imageHeight,
                    //     keepConnected: keepConnected)

                    // fp.FlutterBluetoothPrinter.printBytes(
                    //     address: selectedDevice!.id.id,
                    //     data: await PdfGenerator.generatePdfImage(),
                    //     keepConnected: true);
                    // await Printing.directPrintPdf(
                    //     format: const PdfPageFormat(5.8 * PdfPageFormat.cm, 20 * PdfPageFormat.cm,
                    //         marginAll: 0.5 * PdfPageFormat.cm),
                    //     printer: Printer(
                    //         url: selectedDevice!.id.id,
                    //         name: selectedDevice?.name,
                    //         model: 'POS-5825DD'),
                    //     usePrinterSettings: false,
                    //     onLayout: (PdfPageFormat format) async {
                    //       final pdf = pdfWidgets.Document();
                    //       pdf.addPage(pdfWidgets.Page(
                    //           pageFormat: const PdfPageFormat(
                    //               5.8 * PdfPageFormat.cm, 20 * PdfPageFormat.cm,
                    //               marginAll: 0.5 * PdfPageFormat.cm),
                    //           textDirection: pdfWidgets.TextDirection.rtl,
                    //           theme: pdfWidgets.ThemeData.withFont(
                    //               base: PdfGenerator.font, bold: PdfGenerator.boldFont),
                    //           build: (context) =>
                    //               pdfWidgets.Column(children: [pdfWidgets.Text("Привет всем")])));
                    //       return pdf.save();
                    //     });
                  },
                  child: const Text("Generate pdf invoice", style: TextStyle(color: Colors.amber))),
              // if (selectedDevice != null) Text("Selected Device: ${selectedDevice?.name}"),
              // Expanded(
              //     child: RefreshIndicator(
              //   onRefresh: () async => scan(),
              //   child: ListView.separated(
              //       separatorBuilder: (context, index) => const Divider(),
              //       itemCount: devices.length,
              //       itemBuilder: (context, index) => InkWell(
              //           onTap: () {
              //             setState(() {
              //               selectedDevice = devices[index].device;
              //             });
              //           },
              //           child: Container(
              //               padding: const EdgeInsets.all(8),
              //               child: Column(children: [
              //                 Text("Name: ${devices[index].device.name}"),
              //                 Text("Address: ${devices[index].device.id}")
              //               ])))),
              // ))
            ]),
      ),
    );
  }
}
