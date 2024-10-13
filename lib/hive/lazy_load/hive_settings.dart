import 'package:flutter_animations_2/hive/lazy_load/model/product_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';

class HiveSettings {
  static HiveSettings? _internal;

  static HiveSettings get internal => _internal ??= HiveSettings._();

  HiveSettings._();

  Future<void> initHive() async {
    await Hive.initFlutter();
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


    // in order to put object of your own class you have to
    // register them as adapter

    // await box.put('todo_hive', TodoHive(id: "1", todo: "Okey"));
    //
    // final todoHive = await box.get('todo_hive');
    //
    // print(todoHive);


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
    await box.deleteFromDisk(); // removes all data and closes the box


    print(box.keys);

    // it's perfectly fine to leave a box open for the runtime of the app
    // if you need a box in the future, just leave it open
    // don't use if you did .deleteFromDisk() because it deletes and closes box
    await box.close();
  }
}
