import 'package:flutter_animations_2/hive/users_todo_test/models/users_test.dart';
import 'package:flutter_animations_2/hive/users_todo_test/models/users_todo_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UsersTodoHiveDatabase {
  static UsersTodoHiveDatabase? _internal;

  static UsersTodoHiveDatabase get internal =>
      _internal ??= UsersTodoHiveDatabase._();

  UsersTodoHiveDatabase._();

  Future<void> initDatabase() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UsersTestAdapter());
    Hive.registerAdapter(UsersTestTodoAdapter());

    await Hive.openBox<UsersTest>('users_box_test');
    await Hive.openBox<UsersTestTodo>("users_todo_box_test");
  }

  List<UsersTest> usersList() {
    // openBox - does exactly same thing but first sees if box prev was opened it will return
    // instance of that box
    //
    // box return a previously opened box
    // that is why you have to open box before calling just .box()
    final usersBox = Hive.box<UsersTest>('users_box_test');

    return usersBox.values.toList();
  }

  Future<void> addUser(UsersTest user) async {
    // openBox - does exactly same thing but first sees if box prev was opened it will return
    // instance of that box
    //
    // box return a previously opened box
    // that is why you have to open box before calling just .box()
    final usersBox = await Hive.openBox<UsersTest>('users_box_test');

    usersBox.add(user);
  }

  Future<void> putTodoIntoUsers(UsersTest user, UsersTestTodo todo) async {
    // openBox - does exactly same thing but first sees if box prev was opened it will return
    // instance of that box
    //
    // box return a previously opened box
    // that is why you have to open box before calling just .box()
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
