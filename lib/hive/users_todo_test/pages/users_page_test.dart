import 'package:flutter/material.dart';
import 'package:flutter_animations_2/hive/users_todo_test/pages/users_todo_page_test.dart';
import 'package:flutter_animations_2/hive/users_todo_test/user_test_change_notifier_provider.dart';
import 'package:flutter_animations_2/hive/users_todo_test/viewmodel/users_todo_vm.dart';

class UsersPageTest extends StatefulWidget {
  const UsersPageTest({super.key});

  @override
  State<UsersPageTest> createState() => _UsersPageTestState();
}

class _UsersPageTestState extends State<UsersPageTest> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (v) {
        UserTestChangeNotifierProvider.read<UsersTodoVm>(context)?.init();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final usersTodoVm = UserTestChangeNotifierProvider.watch<UsersTodoVm>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users page test"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const _AddUserScreen();
              },
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          UserTestChangeNotifierProvider.read<UsersTodoVm>(context)?.init();
        },
        child: ListView.separated(
          itemCount: usersTodoVm?.usersPageStateModel.usersTest.length ?? 0,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final item = usersTodoVm?.usersPageStateModel.usersTest[index];
            return ListTile(
              title: Text("Name: ${item?.name}"),
              subtitle: Text("Age: ${item?.age}"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return UsersTodoPageTest(
                        usersTest: item!,
                      );
                    },
                  ),
                );
              },
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
    );
  }
}

class _AddUserScreen extends StatefulWidget {
  const _AddUserScreen();

  @override
  State<_AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<_AddUserScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add User"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_nameController.text.isEmpty || _ageController.text.isEmpty) {
            return;
          }
          UserTestChangeNotifierProvider.read<UsersTodoVm>(context)?.addUser(
            name: _nameController.text.trim(),
            age: int.tryParse(_ageController.text.trim()) ?? 0,
          );
          Navigator.pop(context);
        },
        child: const Icon(Icons.save),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(hintText: "Name"),
            ),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(hintText: "Age"),
            ),
          ],
        ),
      ),
    );
  }
}
