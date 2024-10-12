import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoMvvmView extends StatefulWidget {
  const TodoMvvmView({super.key});

  @override
  State<TodoMvvmView> createState() => _TodoMvvmViewState();
}

class _TodoMvvmViewState extends State<TodoMvvmView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text("Todo with MVVM"),
          ),

        ],
      ),
    );
  }
}
