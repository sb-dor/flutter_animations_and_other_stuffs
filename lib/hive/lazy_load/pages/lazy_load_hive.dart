import 'package:flutter/material.dart';
import 'package:flutter_animations_2/hive/lazy_load/hive_settings.dart';

class LazyLoadHive extends StatefulWidget {
  const LazyLoadHive({super.key});

  @override
  State<LazyLoadHive> createState() => _LazyLoadHiveState();
}

class _LazyLoadHiveState extends State<LazyLoadHive> {
  final _hiveSettings = HiveSettings.internal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lazy load hive"),
      ),
      body: ListView(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                _hiveSettings.doSome();
              },
              child: Text("Do some"),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                _hiveSettings.saveTodos();
              },
              child: Text("Save todos"),
            ),
          ),
        ],
      ),
    );
  }
}
