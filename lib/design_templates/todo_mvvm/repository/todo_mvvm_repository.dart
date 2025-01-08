import 'package:flutter_animations_2/design_templates/todo_mvvm/models/todo_mvvm.dart';
import 'package:flutter_animations_2/design_templates/todo_mvvm/repository/todo_mvvm_service.dart';

class TodoMVVMRepository {
  final TodoMVVMService _todoMVVMService = TodoMVVMService();

  Future<List<TodoMVVM>> getTodos() => _todoMVVMService.getTodos();
}
