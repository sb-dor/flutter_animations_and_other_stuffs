import 'package:flutter/material.dart';
import 'package:flutter_animations_2/material3/material_changer_cubit/material_change_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaterialButtons extends StatelessWidget {
  const MaterialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () => [],
            label: const Text("Expanded FAB"),
            icon: const Icon(Icons.add),
          ),
          FloatingActionButton.large(
            onPressed: () => [],
            child: const Text("larg fab"),
          ),
          FloatingActionButton.small(
            onPressed: () => [],
            child: const Text("small"),
          ),
        ],
      ),
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
      body: ListView(padding: const EdgeInsets.only(left: 10, right: 10), children: [
        const SizedBox(height: 20),
        ElevatedButton(onPressed: () => [], child: const Text('Elevated button')),
        const SizedBox(height: 10),
        FilledButton(onPressed: () => [], child: const Text('Filled button')),
        const SizedBox(height: 10),
        FilledButton.tonal(onPressed: () => [], child: const Text('Filled tonal button')),
        const SizedBox(height: 10),
        FilledButton.icon(
            onPressed: () => [],
            icon: const Icon(Icons.import_contacts),
            label: const Text('filled icon button')),
        const SizedBox(height: 10),
        FilledButton.tonalIcon(
            onPressed: () => [],
            icon: const Icon(Icons.import_contacts),
            label: const Text('filled tonal icon button')),
        const SizedBox(height: 10),
        OutlinedButton(onPressed: () => [], child: const Text('OutLined button')),
        const SizedBox(height: 10),
        OutlinedButton.icon(
            onPressed: () => [],
            icon: const Icon(Icons.import_contacts),
            label: const Text('Outlined icon button')),
        const SizedBox(height: 10),
        TextButton(onPressed: () => [], child: const Text('text button')),
        const SizedBox(height: 10),
        TextButton.icon(
            onPressed: () => [],
            icon: const Text('text icon button'),
            label: const Text('text icon button')),
        const SizedBox(height: 10),
      ]),
    );
  }
}
