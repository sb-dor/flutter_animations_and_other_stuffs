import 'package:flutter/material.dart';
import 'package:flutter_animations_2/material3/material_changer_cubit/material_change_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NavigationDestinationLabelBehavior labelBehavior =
        NavigationDestinationLabelBehavior.alwaysShow;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Material Buttons", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
              onPressed: () => context.read<MaterialChangeCubit>().changeToMaterial2(),
              icon: const Icon(Icons.two_k)),
          IconButton(
              onPressed: () => context.read<MaterialChangeCubit>().changeToMaterial3(),
              icon: const Icon(Icons.three_k))
        ],
      ),
      bottomNavigationBar: NavigationBar(labelBehavior: labelBehavior, destinations: const [
        NavigationDestination(icon: Icon(Icons.add), label: "Add"),
        NavigationDestination(icon: Icon(Icons.remove), label: "remove"),
        NavigationDestination(icon: Icon(Icons.delete), label: "delete"),
      ]),
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/segment_button_page',
                    arguments: {"name": "anything"});
              },
              child: const Text("Another page"))),
    );
  }
}

class _AnotherPage extends StatelessWidget {
  const _AnotherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar());
  }
}
