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

  static Stream<List<DatabaseModel>> get databaseModelStream =>
      _databaseStreamController.stream;

  //
  static Future<void> initSqfLiteDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    //on create sees if there any db exists and it never works if there any db exists
    //on update works whenever db exists and last version is not compared to the new version of db
    //whenever you will release your application on google play do not forget to change version of db
    //after changing all stuff in it
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await _databaseTableQueries(db);
    }, onUpgrade: (db, oldVersion, newVersion) async {
      await _databaseTableQueries(db);
    });
  }

  static Future<void> _databaseTableQueries(Database db) async {
    //remember to use "if not exists" in query to check whether db exists
    await db.execute(
        "create table if not exists demo_table (id integer primary key autoincrement, name text, age integer, any_column TEXT)");

    await db.execute(
        'CREATE TABLE if not exists old_table (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, surname TEXT, age INTEGER)');

    //to add new column to table use "try-catch" to not get error if table already has column
    try {
      await db.execute("ALTER TABLE demo_table ADD COLUMN temp_column TEXT");
    } catch (_) {}

    //to drop column you should create new table of old table, copy data from oldTable to the newTable
    //and then rename it
    await _dropColumn(db);
  }

  static Future<void> _dropColumn(Database db) async {
    //create table with another name. name it whatever you want
    await db.execute(
        'CREATE TABLE new_table_name (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER)');

    //put all data from old_table to the new_table
    try {
      var data = await db.query('old_table');
      for (var each in data) {
        await db.insert(
            'new_table_name', {"name": each['name'], "age": each['age']});
      }
    } catch (_) {}

    //delete old table
    await db.execute("DROP TABLE IF EXISTS old_table");
    //then rename new created table to you past table name
    await db.execute("ALTER TABLE new_table_name RENAME TO old_table");
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

      await database?.delete('demo_table',
          where: "id = ?", whereArgs: [lastDatabaseModel?.id]);

      _databaseStreamController.sink.add(await getAllFromDatabase());
    } catch (e) {
      debugPrint("$e");
    }
  }
}
