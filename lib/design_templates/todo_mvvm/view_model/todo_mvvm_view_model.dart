import 'package:flutter/foundation.dart';
import 'package:flutter_animations_2/design_templates/todo_mvvm/models/todo_mvvm.dart';

import 'state_models/todo_list_mvvm_state_model.dart';

class TodoMvvmViewModel extends ChangeNotifier {
  final TodoListMVVMStateModel todoListMVVMStateService = TodoListMVVMStateModel();

  Future<void> initTodos() async {
    await todoListMVVMStateService.initTodos();
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
