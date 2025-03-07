import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_animations_2/excel/excel_converter/bloc/excel_converter_bloc.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

class _TypeOfSolve {
  String type;

  _TypeOfSolve({required this.type});
}

class ExcelPage extends StatefulWidget {
  const ExcelPage({super.key});

  @override
  State<ExcelPage> createState() => _ExcelPageState();
}

class _ExcelPageState extends State<ExcelPage> {
  TextEditingController fieldForSearchController =
      TextEditingController(text: '');
  String nameOfColumn = '';
  _TypeOfSolve _typeOfSolve = _TypeOfSolve(type: 'average');
  _TypeOfSolve? tempOfSolve;
  Map<String, double> res = {};
  bool saved = false;

  FilePickerResult? pickingFile;

  // here we will pick the file and check if that file is excel file
  Future<void> pickFile() async {
    try {
      pickingFile = await FilePicker.platform.pickFiles();
      if (pickingFile != null) {
        File file = File(pickingFile!.files.single.path!);
        debugPrint("excel file path: ${file.path}");

        if (path.extension(file.path) == '.xlsx' ||
            path.extension(file.path) == '.xls') {
          var bytes = await File(file.path).readAsBytes();
          var excel = Excel.decodeBytes(bytes);
          excelFileFunc(excel: excel);
        } else {
          showMessage(message: "File is not excel file");
        }
      }
    } catch (e) {
      showMessage(message: "Can not open excel file");
      debugPrint("file error is $e");
    }
  }

  void excelFileFunc({required Excel excel}) {
    for (var table in excel.tables.keys) {
      debugPrint("sheet name: $table"); //sheet Name
      debugPrint("maxColumns: ${excel.tables[table]?.maxColumns}");
      debugPrint("maxRows: ${excel.tables[table]?.maxRows}");

      int indexOfTitle = excel.tables[table]?.rows[0].indexWhere((element) =>
              element?.value.toString().toLowerCase() ==
              nameOfColumn.trim().toLowerCase()) ??
          -1;
      if (indexOfTitle == -1) {
        showMessage(message: "Field was not found");
        continue;
      }
      double result = 0.0;
      int count = 0;
      for (var eachRow in excel.tables[table]?.rows ?? <List<List<Data?>>>[]) {
        Data? data = eachRow[indexOfTitle] as Data?;
        if (countingDaysForNumber(data?.value.toString() ?? '') != 0) {
          result += countingDaysForNumber(data?.value.toString() ?? '');
          count++;
        }
      }
      if (_typeOfSolve.type == 'average') {
        result = double.parse((result / count).toStringAsFixed(2));
      }
      if (result.isNaN) {
        showMessage(message: "Not a number field");
        result = 0.0;
      }
      res[table] = result;
    }
    setState(() {});
  }

  int countingDaysForNumber(String date) {
    if (DateTime.tryParse(date) == null) return 0;
    DateTime dateFrom = DateTime(1899, 12, 30);
    DateTime dateTo = DateTime.parse(date);
    return dateTo.difference(dateFrom).inDays.abs();
  }

  void showMessage({String? message}) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message ?? "Error to open file")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Excel file parser"),
        actions: [
          IconButton(
            onPressed: () {
              context.read<ExcelConversionBloc>().add(
                ExcelConversionEvent.pickFile(onErrorMessage: (message) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(message)),
                  );
                }),
              );
            },
            icon: const Icon(Icons.cloud_upload),
          ),
        ],
      ),
      body: ListView(
          padding: const EdgeInsets.only(left: 10, right: 10),
          children: [
            Row(children: [
              Expanded(
                  child: TextField(
                controller: fieldForSearchController,
                decoration: const InputDecoration(
                    hintText: "Field for doing something"),
              )),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          tempOfSolve?.type == "average"
                              ? Colors.orange
                              : null)),
                  onPressed: () => setState(() {
                        tempOfSolve = _TypeOfSolve(type: "average");
                        saved = false;
                      }),
                  child: const Text("AV")),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          tempOfSolve?.type == "sum" ? Colors.orange : null)),
                  onPressed: () => setState(() {
                        tempOfSolve = _TypeOfSolve(type: "sum");
                        saved = false;
                      }),
                  child: const Text("SUM")),
            ]),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async => pickFile(),
                  child: const Text("Pick excel file"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      nameOfColumn = fieldForSearchController.text.trim();
                      if (tempOfSolve != null && nameOfColumn.isNotEmpty) {
                        saved = true;
                        _typeOfSolve = tempOfSolve!;
                      } else {
                        showMessage(
                            message: "Choose type and check field name");
                      }
                    });
                  },
                  child: const Text("Save"),
                ),
              ],
            ),
            Column(
                children: res.entries
                    .map((e) => Row(children: [
                          Text("Table: ${e.key} | "),
                          Expanded(child: Text("Value: ${e.value}"))
                        ]))
                    .toList())
          ]),
    );
  }
}
