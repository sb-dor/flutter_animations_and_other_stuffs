// class that does something with database
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import 'app_database.dart';
import 'tables/todo_drift_db_table.dart';

@immutable
class DealWithDatabase {
  final AppDatabase _database;

  const DealWithDatabase(this._database);

  Future<void> saveTodo(TodoDrift todo) async {
    var data = await _database.managers.todoDriftDbTable
        .filter(
          (e) => e.id(todo.id),
        )
        .getSingleOrNull();

    if (data != null) {
      data = data.copyWith(
        name: todo.name,
      );

      await _database.managers.todoDriftDbTable.replace(data);
    } else {
      await _database.into(_database.todoDriftDbTable).insert(
            TodoDriftDbTableCompanion.insert(
              name: todo.name,
              createdAt: Value(todo.createdAt),
            ),
          );
    }
  }

  //
  Future<void> delete(TodoDrift todo) =>
      _database.managers.todoDriftDbTable.filter((element) => element.id(todo.id)).delete();
}
