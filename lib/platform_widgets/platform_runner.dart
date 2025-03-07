import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cupertino_text_fields.dart';
import 'platform_sliver_navigation_bar.dart';

class PlatformRunner extends StatelessWidget {
  const PlatformRunner({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: _MaterialApp(),
    );
  }
}

class _CupertinoApp extends StatelessWidget {
  const _CupertinoApp();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("Cupertino appbar"),
        trailing: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) {
                  return const PlatformSliverNavigationBar();
                },
              ),
            );
          },
          icon: const Icon(CupertinoIcons.add_circled),
        ),
      ),
      child: const Center(
        child: SizedBox.expand(
          child: CupertinoTextFields(),
        ),
      ),
    );
  }
}

class _MaterialApp extends StatelessWidget {
  const _MaterialApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Material appbar"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const PlatformSliverNavigationBar();
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: const SizedBox.expand(
        child: Center(
          child: CupertinoTextFields(),
        ),
      ),
    );
  }
}
