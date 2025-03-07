import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations_2/design_templates/todo_mvvm/view_model/todo_mvvm_view_model.dart';
import 'package:provider/provider.dart';

class TodoMvvmView extends StatelessWidget {
  const TodoMvvmView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TodoMvvmViewModel(),
      child: const _TodoMvvmViewHelper(),
    );
  }
}

class _TodoMvvmViewHelper extends StatefulWidget {
  const _TodoMvvmViewHelper();

  @override
  State<_TodoMvvmViewHelper> createState() => _TodoMvvmViewHelperState();
}

class _TodoMvvmViewHelperState extends State<_TodoMvvmViewHelper> {
  final TextEditingController _todoTextController = TextEditingController();

  @override
  void dispose() {
    _todoTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<TodoMvvmViewModel>().initTodos();
  }

  @override
  Widget build(BuildContext context) {
    final todoMVVMViewModel = context.watch<TodoMvvmViewModel>();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text("Todo with MVVM"),
          ),

          // for test one
          SliverToBoxAdapter(
            child: ChangeNotifierProvider<TodoMvvmViewModel>(
              create: (context) => TodoMvvmViewModel(),
              builder: (context, child) {
                return child!;
              },
              child: Builder(
                builder: (context) {
                  final intValue = context.watch<TodoMvvmViewModel>();
                  return TextButton(
                    onPressed: () {
                      if (_todoTextController.text.trim().isEmpty) return;
                      context.read<TodoMvvmViewModel>().addTodo(_todoTextController.text.trim());
                    },
                    child: Text("${intValue.todoListMVVMStateService.todoMVVM.length}"),
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              children: [
                Expanded(
                  child: CupertinoTextFormFieldRow(
                    controller: _todoTextController,
                    prefix: const Text("TODO name"),
                    placeholder: "Enter Text",
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (_todoTextController.text.trim().isEmpty) return;
                    todoMVVMViewModel.addTodo(_todoTextController.text.trim());
                  },
                  icon: const Icon(
                    CupertinoIcons.add,
                    color: CupertinoColors.activeGreen,
                  ),
                ),
              ],
            ),
          ),
          SliverList.separated(
            itemCount: todoMVVMViewModel.todoListMVVMStateService.todoMVVM.length,
            itemBuilder: (context, index) {
              final item = todoMVVMViewModel.todoListMVVMStateService.todoMVVM[index];
              return CupertinoListTile(
                title: Text(item.todo),
                trailing: IconButton(
                  onPressed: () {
                    todoMVVMViewModel.removeTodo(item);
                  },
                  icon: const Icon(CupertinoIcons.delete),
                  color: CupertinoColors.destructiveRed,
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
          ),
        ],
      ),
    );
  }
}
