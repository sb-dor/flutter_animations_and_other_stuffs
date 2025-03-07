import 'package:flutter/material.dart';
import 'package:flutter_animations_2/hive/users_todo_test/models/users_test.dart';
import 'package:flutter_animations_2/hive/users_todo_test/user_test_change_notifier_provider.dart';
import 'package:flutter_animations_2/hive/users_todo_test/viewmodel/users_todo_vm.dart';

class UsersTodoPageTest extends StatefulWidget {
  final UsersTest usersTest;

  const UsersTodoPageTest({
    super.key,
    required this.usersTest,
  });

  @override
  State<UsersTodoPageTest> createState() => _UsersTodoPageTestState();
}

class _UsersTodoPageTestState extends State<UsersTodoPageTest> {
  final TextEditingController _todoController = TextEditingController();

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.usersTest.name} todo"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_todoController.text.isEmpty) return;
          UserTestChangeNotifierProvider.read<UsersTodoVm>(context)
              ?.addTodoToUser(
            user: widget.usersTest,
            todoText: _todoController.text.trim(),
          );
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Todo was saved try to refresh screen"),
              duration: Duration(seconds: 3),
            ),
          );
        },
        child: const Icon(Icons.save),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _todoController,
              decoration: const InputDecoration(hintText: "Todo"),
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: widget.usersTest.usersTestTodo?.length ?? 0,
                itemBuilder: (context, index) {
                  final item = widget.usersTest.usersTestTodo?[index];
                  return ListTile(
                    title: Text("${item?.todo}"),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.delete,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
