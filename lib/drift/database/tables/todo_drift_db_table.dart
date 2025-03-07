import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_animations_2/drift/database/app_database.dart';

@immutable
class TodoDrift {
  final int? id;
  final String? name;
  final String? content;
  final String? author;
  final String? createdAt;

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

  // was changes to nullable()
  TextColumn get name => text().nullable()();

  TextColumn get content =>
      text().nullable()(); // added for 2 version two of database

  TextColumn get author =>
      text().nullable()(); // added for 4 version two of database

  // it was datetime column -> was changed into String
  TextColumn get createdAt => text().nullable()();
}
