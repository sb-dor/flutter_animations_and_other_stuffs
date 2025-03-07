import 'package:hive/hive.dart';

part 'users_todo_test.g.dart';

@HiveType(typeId: 4)
class UsersTestTodo extends HiveObject {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String? todo;

  UsersTestTodo({
    required this.id,
    required this.todo,
  });
}
