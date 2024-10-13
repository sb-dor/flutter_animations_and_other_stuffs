import 'package:flutter/material.dart';
import 'package:flutter_animations_2/hive/users_todo_test/user_test_change_notifier_provider.dart';
import 'package:flutter_animations_2/hive/users_todo_test/viewmodel/users_todo_vm.dart';

class UsersPageTest extends StatefulWidget {
  const UsersPageTest({super.key});

  @override
  State<UsersPageTest> createState() => _UsersPageTestState();
}

class _UsersPageTestState extends State<UsersPageTest> {
  final _usersTodoVM = UsersTodoVm();

  @override
  Widget build(BuildContext context) {
    return UserTestChangeNotifierProvider(
      provider: _usersTodoVM,
      child: const _UsersPageTestHelper(),
    );
  }
}

class _UsersPageTestHelper extends StatefulWidget {
  const _UsersPageTestHelper({super.key});

  @override
  State<_UsersPageTestHelper> createState() => _UsersPageTestHelperState();
}

class _UsersPageTestHelperState extends State<_UsersPageTestHelper> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
