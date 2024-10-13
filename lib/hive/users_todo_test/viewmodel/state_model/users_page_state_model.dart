import 'package:flutter_animations_2/hive/users_todo_test/hive_database/users_todo_hive_database.dart';
import 'package:flutter_animations_2/hive/users_todo_test/models/users_test.dart';
import 'package:uuid/uuid.dart';

class UsersPageStateModel {
  final UsersTodoHiveDatabase _usersTodoHiveDatabase = UsersTodoHiveDatabase.internal;

  final List<UsersTest> usersTest = [];

  void clearAll() => usersTest.clear();

  void addAll(List<UsersTest> list) => usersTest.addAll(usersTest);

  Future<void> init() async => usersTest.addAll(await _usersTodoHiveDatabase.usersList());

  Future<void> addUser({required String name, required int age}) async {
    final user = UsersTest(
      id: const Uuid().v4(),
      name: name,
      age: age,
    );
    await _usersTodoHiveDatabase.addUser(user);
  }
}
