import 'package:drift/drift.dart';
import 'package:flutter_animations_2/drift/database/app_database.dart';
import 'package:flutter_animations_2/drift/database/tables/todo_drift_db_table.dart';

final class TodoDriftDatabaseHelper {
  final AppDatabase _database;

  TodoDriftDatabaseHelper(this._database);

  Future<void> saveTodo(TodoDrift todo) async {
    await _database.transaction(
      () async {
        var data = await _database.managers.todoDriftDbTable
            .filter(
              (e) => e.id(todo.id),
            )
            .getSingleOrNull();

        final d = await (_database.select(_database.todoDriftDbTable)
              ..where((element) => element.id.equals(todo.id!)))
            .getSingle();

        if (data != null) {
          data = data.copyWith(
            name: Value(todo.name),
          );

          await _database.managers.todoDriftDbTable.replace(data);
        } else {
          await _database.into(_database.todoDriftDbTable).insert(
                TodoDriftDbTableCompanion.insert(
                  name: Value(todo.name),
                  content: Value(todo.content),
                  author: Value(todo.author),
                  createdAt: Value(todo.createdAt),
                ),
              );
        }
      },
    );
  }

  //
  Future<void> delete(TodoDrift todo) => _database.managers.todoDriftDbTable
      .filter((element) => element.id(todo.id))
      .delete();

  Future<List<TodoDrift>> get todos async {
    final data = await _database.select(_database.todoDriftDbTable).get();
    return data.map((element) => TodoDrift.fromTable(element)).toList();
  }

  // about expressions:
  // https://drift.simonbinder.eu/dart_api/expressions/
  Future<List<TodoDrift>> get todosGrouped async {
    final data = await (_database.select(_database.todoDriftDbTable)
          ..where(
            (element) =>
                element.name.length.isBiggerThan(const Variable(10)) |
                element.author.length.isSmallerThan(const Variable(20)),
          ))
        .get();

    return data.map((e) => TodoDrift.fromTable(e)).toList();
  }
}
