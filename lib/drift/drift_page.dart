import 'package:flutter/material.dart';
import 'package:flutter_animations_2/drift/database/app_database.dart';
import 'package:flutter_animations_2/drift/database/database_helpers/todo_drift_database_helper.dart';
import 'package:flutter_animations_2/drift/database/tables/todo_drift_db_table.dart';
import 'package:provider/provider.dart';

// all app dependencies
//
//
@immutable
class Dependencies {
  final AppDatabase appDatabase;

  const Dependencies(this.appDatabase);
}

//
//
//
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final appDatabase = AppDatabase.defaults();

  runApp(
    Provider(
      create: (_) => Dependencies(appDatabase),
      child: const MaterialApp(
        home: DriftPage(),
      ),
    ),
  );
}

//
//
//
class DriftPage extends StatefulWidget {
  const DriftPage({super.key});

  @override
  State<DriftPage> createState() => _DriftPageState();
}

class _DriftPageState extends State<DriftPage> {
  late final TodoDriftDatabaseHelper _todoDriftDatabaseHelper;

  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _contextEditingController =
      TextEditingController();
  final TextEditingController _authorEditingController =
      TextEditingController();

  final List<TodoDrift> _todos = [];

  @override
  void initState() {
    super.initState();
    _todoDriftDatabaseHelper = TodoDriftDatabaseHelper(
      Provider.of<Dependencies>(context, listen: false).appDatabase,
    );
    _getTodos();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _contextEditingController.dispose();
    _authorEditingController.dispose();
    super.dispose();
  }

  Future<void> _addTodo() async {
    if (_textEditingController.text.trim().isEmpty) return;
    final TodoDrift todo = TodoDrift(
      name: _textEditingController.text.trim(),
      content: _contextEditingController.text.trim(),
      author: _authorEditingController.text.trim(),
      createdAt: DateTime.now().toString(),
    );
    await _todoDriftDatabaseHelper.saveTodo(todo);
  }

  void _getTodos() async {
    _todos.clear();
    _todos.addAll(await _todoDriftDatabaseHelper.todos);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App with drift"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(hintText: "Name"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _contextEditingController,
              decoration: const InputDecoration(hintText: "Content"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _authorEditingController,
              decoration: const InputDecoration(hintText: "Author"),
            ),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: () async {
              await _addTodo();
              _getTodos();
            },
            child: const Text("Add todo"),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Todo: ${_todos[index].name}"),
                          const SizedBox(height: 5),
                          Text("Content: ${_todos[index].content ?? ''}"),
                          const SizedBox(height: 5),
                          Text("Author: ${_todos[index].author ?? ''}")
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text("${_todos[index].createdAt}")
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
