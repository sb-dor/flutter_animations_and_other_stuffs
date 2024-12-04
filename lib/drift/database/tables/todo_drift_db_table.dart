import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_animations_2/drift/database/app_database.dart';

@immutable
class TodoDrift {
  final int? id;
  final String name;
  final String? content;
  final String? author;
  final DateTime? createdAt;

  const TodoDrift({
    this.id,
    required this.name,
     this.content,
    this.author,
    required this.createdAt,
  });

  factory TodoDrift.fromTable(TodoDriftDbTableData data) {
    return TodoDrift(
      id: data.id,
      name: data.name,
      content: data.content,
      author: data.author,
      createdAt: data.createdAt,
    );
  }
}

class TodoDriftDbTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get content => text().nullable()(); // added for 2 version two of database

  TextColumn get author => text().nullable()(); // added for 4 version two of database

  DateTimeColumn get createdAt => dateTime().nullable()();
}
