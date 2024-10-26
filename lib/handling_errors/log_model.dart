import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class LogModel extends HiveObject {
  final String? message;
  final String? timeOfError;
  final String? stack;

  LogModel({
    required this.message,
    required this.timeOfError,
    required this.stack,
  });

  Map<String, dynamic> toJson() => {
        "message": message,
        "time_of_error": timeOfError,
        "stack": stack,
      };

  factory LogModel.fromHive(Map<dynamic, dynamic> json) {
    return LogModel(
      message: json['message'] as String?,
      timeOfError: json['time_of_error'] as String?,
      stack: json['stack'] as String?,
    );
  }
}

// adapter is saved inside - lib/hive/lazy_load/hive_settings.dart
class LogAdapter extends TypeAdapter<LogModel> {
  @override
  LogModel read(BinaryReader reader) {
    return LogModel.fromHive(reader.readMap());
  }

  @override
  int get typeId => 4;

  @override
  void write(BinaryWriter writer, LogModel obj) {
    writer.writeMap(obj.toJson());
  }
}
