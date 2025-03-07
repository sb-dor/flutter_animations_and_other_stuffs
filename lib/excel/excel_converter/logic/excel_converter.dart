import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';

class ExcelConverter {
  //
  Future<List<Map<String, dynamic>>> convert(Excel excel) async {
    String convertCellValueToString(CellValue? cellValue) {
      if (cellValue == null) return '';
      if (cellValue is FormulaCellValue) return cellValue.formula;
      if (cellValue is IntCellValue) return cellValue.value.toString();
      if (cellValue is DoubleCellValue) return cellValue.value.toString();
      if (cellValue is DateCellValue) {
        return cellValue.asDateTimeUtc().toString();
      }
      if (cellValue is TextCellValue) return cellValue.value.text ?? '';
      if (cellValue is BoolCellValue) return cellValue.value.toString();
      if (cellValue is TimeCellValue) return cellValue.asDuration().toString();
      if (cellValue is DateTimeCellValue) {
        return cellValue.asDateTimeUtc().toString();
      }
      return '';
    }

    List<String> columnHeaders = [];
    List<Map<String, dynamic>> dataRows = [];

    for (var table in excel.tables.keys) {
      final rows = (excel.tables[table]?.rows ?? <List<Data?>>[]);

      for (int i = 0; i < rows.length; i++) {
        final row = rows[i];

        if (i == 0) {
          columnHeaders =
              row.map((cell) => convertCellValueToString(cell?.value)).toList();
          continue;
        }

        if (columnHeaders.isEmpty) {
          continue;
        }

        final Map<String, dynamic> rowData = {};
        for (int k = 0; k < row.length; k++) {
          final header = columnHeaders[k];
          final cell = row[k]?.value;
          rowData[header] = convertCellValueToString(cell);
        }
        dataRows.add(rowData);
      }
    }

    debugPrint("$dataRows");

    return dataRows;
  }

  Future<List<Map<String, dynamic>>> convertCSV(
      List<List<dynamic>> csvData) async {
    List<String> columnHeaders =
        csvData.first.map((header) => header.toString()).toList();

    columnHeaders = columnHeaders.first.split(";");

    List<Map<String, dynamic>> csvMappedData = [];

    for (final row in csvData.skip(1)) {
      final Map<String, dynamic> rowData = {};

      final List<String> rowDecode = row.first.toString().split(";");

      for (int i = 0; i < rowDecode.length; i++) {
        final header = columnHeaders[i];
        rowData[header] = rowDecode[i];
      }

      csvMappedData.add(rowData);
    }

    debugPrint("$csvMappedData");

    return csvMappedData;
  }
}
