import 'dart:developer';

import 'package:flutter_animations_2/handling_errors/log_model.dart';
import 'package:flutter_animations_2/hive/lazy_load/generated_model/generated_hive_model.dart';
import 'package:flutter_animations_2/hive/lazy_load/model/product_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

class HiveSettings {
  static HiveSettings? _internal;

  static HiveSettings get internal => _internal ??= HiveSettings._();

  HiveSettings._();

  Future<void> initHive() async {
    await Hive.initFlutter();
    // register adapters
    Hive.registerAdapter(TodoHiveAdapter());
    Hive.registerAdapter(GeneratedHiveModelAdapter());
    Hive.registerAdapter(LogAdapter());
  }

  void doSome() async {
    final box = await Hive.openBox('test_box');

    await box.put('name', 'avaz');

    final name = await box.get('name', defaultValue: 'no user');

    print("name: is: $name");

    await box.put('age', 21);

    final age = await box.get('age', defaultValue: 0);

    print("name: is: $age");

    // you can set array

    await box.put('friends', ["Mick", "Hafiz"]);

    final friends = await box.get('friends');

    print(friends);

    // you can use "add" in box to add things inside
    // but getting will be with index (int)
    final index = await box.add("anything");

    final getByIndex = await box.getAt(index);

    print(getByIndex);

    print(box.keys);

    // deletion
    // await box.delete('name');
    await box.delete('friends'); // deletion with key
    await box.deleteAt(index); // deletion with index
    // await box.deleteFromDisk(); // removes all data and closes the box

    //
    final anotherBox = Hive.box('my_box'); // returns previously opened box

    anotherBox.put('any', '1');

    print(box.keys);

    // it's perfectly fine to leave a box open for the runtime of the app
    // if you need a box in the future, just leave it open
    // don't use if you did .deleteFromDisk() because it deletes and closes box
    await box.close();

    // you don't have to get data after closing box
  }

  void saveTodos() async {
    // in order to put object of your own class you have to
    // register them as adapter

    final box = await Hive.openBox<TodoHive>('todo_box');

    final todo = TodoHive(id: const Uuid().v4(), todo: "Okay");

    final index = await box.add(todo);

    box.toMap().entries.map((element) {
      print("key is: ${element.key} | value: ${element.value}");
    });

    final todoHive = box.getAt(index);

    print("${box.values.length} | ${box.values}");
  }

  void saveGeneratedModel() async {
    // in order to put object of your own class you have to
    // register them as adapter

    final box = await Hive.openBox<GeneratedHiveModel>('generated_hive_model_box');

    final generatedModel = GeneratedHiveModel(id: const Uuid().v4(), age: 20, changeName: 'Avaz');

    final index = await box.add(generatedModel);

    box.toMap().entries.map((element) {
      print("key is: ${element.key} | value: ${element.value}");
    });

    final generated = box.getAt(index);

    log("${box.values.length} | ${box.values}");
  }

  Future<void> saveLogs(List<LogModel> logs) async {
    final box = await Hive.openBox<LogModel>('logs');

    for (final log in logs) {
      await box.add(log);
    }
  }

  Future<List<LogModel>> getLogs() async {
    final box = await Hive.openBox<LogModel>('logs');
    return box.values.toList();
  }
}
