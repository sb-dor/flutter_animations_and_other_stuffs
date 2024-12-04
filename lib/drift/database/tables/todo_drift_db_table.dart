import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_animations_2/drift/database/app_database.dart';

@immutable
class TodoDrift {
  final int id;
  final String name;
  final DateTime? createdAt;

  const TodoDrift({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  factory TodoDrift.fromTable(TodoDriftDbTableData data) {
    return TodoDrift(
      id: data.id,
      name: data.name,
      createdAt: data.createdAt,
    );
  }
}

class TodoDriftDbTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  DateTimeColumn get createdAt => dateTime().nullable()();
}
