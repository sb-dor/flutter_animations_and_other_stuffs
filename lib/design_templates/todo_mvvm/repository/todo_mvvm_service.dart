import 'package:flutter_animations_2/design_templates/todo_mvvm/models/todo_mvvm.dart';
import 'package:flutter_animations_2/design_templates/todo_mvvm/repository/todo_mvvm_repository.dart';

class TodoMVVMService {
  final TodoMVVMRepository _mvvmRepository = TodoMVVMRepository();

  Future<List<TodoMVVM>> getTodos() => _mvvmRepository.getTodos();
}
