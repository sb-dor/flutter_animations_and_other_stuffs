import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_animations_2/design_templates/todo_mvvm/models/todo_mvvm.dart';
import 'package:flutter_animations_2/design_templates/todo_mvvm/repository/todo_mvvm_service.dart';
import 'package:flutter_animations_2/design_templates/todo_mvvm/view_model/state_services/todo_list_mvvm_state_service.dart';

class TodoMvvmViewModel extends ChangeNotifier {
  final TodoListMVVMStateService todoListMVVMStateService = TodoListMVVMStateService();
  final TodoMVVMService _todoMVVMService = TodoMVVMService();

  Future<void> initTodos() async {
    todoListMVVMStateService.clearAllTodos();
    todoListMVVMStateService.addTodos(await _todoMVVMService.getTodos());
    notifyListeners();
  }

  void addTodo(String todo) {
    todoListMVVMStateService.addTodo(todo);
    notifyListeners();
  }

  void removeTodo(TodoMVVM todo) {
    todoListMVVMStateService.removeTodo(todo);
    notifyListeners();
  }
}
