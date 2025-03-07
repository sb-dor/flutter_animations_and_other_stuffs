import 'package:flutter/cupertino.dart';
import 'package:flutter_animations_2/hive/users_todo_test/models/users_test.dart';

import 'state_model/users_page_state_model.dart';
import 'state_model/users_todo_page_state_model.dart';

class UsersTodoVm extends ChangeNotifier {
  //
  final UsersPageStateModel usersPageStateModel = UsersPageStateModel();
  final UsersTodoPageStateModel usersTodoPageStateModel =
      UsersTodoPageStateModel();

//

  void init() async {
    usersPageStateModel.clearAll();
    await usersPageStateModel.init();
    notifyListeners();
  }

  void addUser({required String name, required int age}) async {
    await usersPageStateModel.addUser(
      name: name,
      age: age,
    );
    init();
  }

  void addTodoToUser({
    required UsersTest user,
    required String todoText,
  }) async {
    await usersPageStateModel.addTodoToUser(user: user, todoText: todoText);
    init();
  }
}
