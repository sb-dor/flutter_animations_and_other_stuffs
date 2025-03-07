import 'dart:collection';

import 'package:flutter_animations_2/design_templates/todo_mvvm/models/todo_mvvm.dart';
import 'package:flutter_animations_2/design_templates/todo_mvvm/repository/todo_mvvm_repository.dart';

class TodoListMVVMStateModel {
  final TodoMVVMRepository _todoMVVMService = TodoMVVMRepository();

  final List<TodoMVVM> _todoMVVM = [];

  UnmodifiableListView<TodoMVVM> get todoMVVM => UnmodifiableListView(_todoMVVM);

  void _clearAllTodos() => _todoMVVM.clear();

  void _addTodos(List<TodoMVVM> todos) => _todoMVVM.addAll(todos);

  Future<void> initTodos() async {
    _clearAllTodos();
    _addTodos(await _todoMVVMService.getTodos());
  }

  void addTodo(String todo) {
    _todoMVVM.add(
      TodoMVVM(todo: todo),
    );
  }

  void removeTodo(TodoMVVM todo) {
    _todoMVVM.removeWhere((eachTodo) => eachTodo.id == todo.id);
  }
}
