import 'package:flutter_animations_2/hive/lazy_load/hive_settings.dart';
import 'package:flutter_animations_2/hive/users_todo_test/models/users_test.dart';
import 'package:flutter_animations_2/hive/users_todo_test/models/users_todo_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UsersTodoHiveDatabase {
  static UsersTodoHiveDatabase? _internal;

  static UsersTodoHiveDatabase get internal => _internal ??= UsersTodoHiveDatabase._();

  UsersTodoHiveDatabase._();

  Future<void> initDatabase() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UsersTestAdapter());
    Hive.registerAdapter(UsersTestTodoAdapter());
  }

  Future<List<UsersTest>> usersList() async {
    final usersBox = Hive.openBox<UsersTest>('users_box_test');

    return (await usersBox).values.toList();
  }

  Future<void> addUser(UsersTest user) async {
    final usersBox = await Hive.openBox<UsersTest>('users_box_test');

    usersBox.add(user);
  }

  Future<void> putTodoIntoUsers(UsersTest user, UsersTestTodo todo) async {
    // final usersBox = await Hive.openBox<UsersTest>('users_box_test');
    final todoBox = await Hive.openBox<UsersTestTodo>("users_todo_box_test");

    todoBox.add(todo);
    final hiveList = HiveList<UsersTestTodo>(
      todoBox,
      objects: [...user.usersTestTodo?.toList() ?? [], todo],
    );

    user.usersTestTodo = hiveList;
    await user.save();
  }
}
