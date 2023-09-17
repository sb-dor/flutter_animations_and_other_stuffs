import 'dart:async';
import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animations_2/sqflite/model/database_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfLiteDatabaseHelper {
  static Database? database;

  static final StreamController<List<DatabaseModel>> _databaseStreamController =
      StreamController<List<DatabaseModel>>.broadcast();

  static Stream<List<DatabaseModel>> get databaseModelStream => _databaseStreamController.stream;

  //
  static Future<void> initSqfLiteDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    database = await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute(
          "create table demo_table (id integer primary key autoincrement, name text, age integer)");
    });
  }

  static Future<void> initStream() async {
    _databaseStreamController.sink.add(await getAllFromDatabase());
  }

  static Future<List<DatabaseModel>> getAllFromDatabase() async {
    var map = await database?.query('demo_table');

    return (map ?? []).map((e) => DatabaseModel.fromDb(e)).toList();
  }

  static Future<void> addDatabaseModel() async {
    try {
      var random = Random();
      DatabaseModel databaseModel =
          DatabaseModel(name: Faker().person.name(), age: random.nextInt(100));
      await database?.insert('demo_table', databaseModel.toMap(),
          conflictAlgorithm: ConflictAlgorithm.ignore);

      _databaseStreamController.sink.add(await getAllFromDatabase());
    } catch (e) {
      debugPrint("$e");
    }
  }

  static Future<void> deleteLast() async {
    try {
      List<DatabaseModel> list = await getAllFromDatabase();
      DatabaseModel? lastDatabaseModel = list.isNotEmpty ? list.last : null;

      await database?.delete('demo_table', where: "id = ?", whereArgs: [lastDatabaseModel?.id]);

      _databaseStreamController.sink.add(await getAllFromDatabase());
    } catch (e) {
      debugPrint("$e");
    }
  }
}
