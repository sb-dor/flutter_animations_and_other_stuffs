import 'package:hive/hive.dart';

import 'users_todo_test.dart';

part 'users_test.g.dart';

@HiveType(typeId: 3)
class UsersTest extends HiveObject {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final int? age;

  @HiveField(3)
  HiveList<UsersTestTodo>? usersTestTodo;

  UsersTest({
    required this.id,
    required this.name,
    required this.age,
    this.usersTestTodo,
  });
}
