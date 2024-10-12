import 'package:uuid/uuid.dart';

class TodoMVVM {
  final String id;
  final String todo;

  TodoMVVM({required this.todo}) : id = const Uuid().v4();
}
