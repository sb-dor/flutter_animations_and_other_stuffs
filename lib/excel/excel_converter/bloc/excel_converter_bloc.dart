import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_animations_2/excel/excel_converter/logic/excel_converter.dart';
import 'package:flutter_animations_2/excel/excel_converter/models/excel_converter_product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';

part 'excel_converter_bloc.freezed.dart';

@freezed
@immutable
class ExcelConversionEvent with _$ExcelConversionEvent {
  const factory ExcelConversionEvent.pickFile({
    required void Function(String errorMessage) onErrorMessage,
  }) = _PickFileEventOnProductExcelConversionEvent;
}

@freezed
@immutable
class ExcelConversionState with _$ExcelConversionState {
  const ExcelConversionState._();

  bool get saving => maybeMap(orElse: () => false, saving: (_) => true);

  const factory ExcelConversionState.initial() = InitialStateOnProductExcelConversionState;

  const factory ExcelConversionState.saving() = SavingStateOnProductExcelConversionState;

  const factory ExcelConversionState.successful() = SuccessfulStateOnProductExcelConversionState;
}

class ExcelConversionBloc extends Bloc<ExcelConversionEvent, ExcelConversionState> {
  // final IProductExcelConversionRepo _iProductExcelConversionRepo;

  ExcelConversionBloc() : super(const ExcelConversionState.initial()) {
    //
    on<ExcelConversionEvent>(
      (event, emit) => event.map(
        pickFile: (event) => _pickFile(event, emit),
      ),
    );
  }

  void _pickFile(
    _PickFileEventOnProductExcelConversionEvent event,
    Emitter<ExcelConversionState> emit,
  ) async {
    try {
      if (state.saving) return;

      final excelConverter = ExcelConverter();

      final pickFiles = await FilePicker.platform.pickFiles(
        allowedExtensions: [
          'xlsx',
          // 'xls',
          'csv',
        ],
        type: FileType.custom,
        allowMultiple: false,
      );

      if (pickFiles == null) return;

      List<File> files = pickFiles.paths.map((path) => File(path!)).toList();

      List<ExcelConverterProduct> products = [];

      for (final each in files) {
        final extension = each.path.split('.').last.toLowerCase();

        if (extension == 'csv') {
          final csvString = await each.readAsString();
          final csvData = const CsvToListConverter().convert(csvString);

          final List<Map<String, dynamic>> jsonData = await excelConverter.convertCSV(csvData);

          products.addAll(jsonData.map((element) => ExcelConverterProduct.fromJsonExcel(element)));
        } else if (extension == "xls") {
          // TODO: write code for xls
          // : Package that Im using does not support XLS
        } else {
          final excelFile = Excel.decodeBytes(await each.readAsBytes());

          final List<Map<String, dynamic>> jsonData = await excelConverter.convert(excelFile);

          products.addAll(jsonData.map((element) => ExcelConverterProduct.fromJsonExcel(element)));
        }
      }

      if (products.isNotEmpty) {
        emit(const ExcelConversionState.saving());

        final saveConvertedProducts = true;
        // await _iProductExcelConversionRepo.saveConvertedProducts(products);

        if (saveConvertedProducts) {
          emit(const ExcelConversionState.successful());
        } else {
          // show message here
        }

        emit(const ExcelConversionState.initial());
      } else {
        event.onErrorMessage("File contains nothing!");
      }

      //
    } catch (error, stackTrace) {
      event.onErrorMessage("Something went wrong");
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
