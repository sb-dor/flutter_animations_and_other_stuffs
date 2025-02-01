import 'package:flutter/material.dart';

class StatelesswidgetTestMarkneedsbuild extends StatelessWidget {
  const StatelesswidgetTestMarkneedsbuild({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: TextButton(
        onPressed: () {
          // you can call like this one
          // but if you are calling from StatefulWidget call "StateFulElement" not "StatelessElement"
          (context as StatelessElement).markNeedsBuild();

          // or you can call like this one
          (context as Element).markNeedsBuild();

          // remember that both of them is context and same thing
        },
        child: Text(DateTime.now().toString()),
      ),
    );
  }
}
