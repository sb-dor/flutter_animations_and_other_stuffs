import 'dart:collection';

import 'package:flutter_animations_2/design_templates/todo_mvvm/models/todo_mvvm.dart';

class TodoListMVVMStateService {
  final List<TodoMVVM> _todoMVVM = [];

  UnmodifiableListView<TodoMVVM> get todoMVVM => UnmodifiableListView(_todoMVVM);

  void clearAllTodos() => _todoMVVM.clear();

  void addTodos(List<TodoMVVM> todos) => _todoMVVM.addAll(todos);

  void addTodo(String todo) {
    _todoMVVM.add(
      TodoMVVM(todo: todo),
    );
  }

  void removeTodo(TodoMVVM todo) {
    _todoMVVM.removeWhere((eachTodo) => eachTodo.id == todo.id);
  }
}
