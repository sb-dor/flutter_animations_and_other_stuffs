import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainWebPageWithUrl extends StatefulWidget {
  const MainWebPageWithUrl({super.key});

  @override
  State<MainWebPageWithUrl> createState() => _MainWebPageWithUrlState();
}

class _MainWebPageWithUrlState extends State<MainWebPageWithUrl> {
  TextEditingController name = TextEditingController(text: '');
  TextEditingController sName = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Url navigation"),
      ),
      body: Column(
        children: [
          TextField(
            controller: name,
          ),
          TextField(
            controller: sName,
          ),
          TextButton(
              onPressed: () {
                context.go(
                  context.namedLocation(
                    'detailsName',
                    pathParameters: {
                      "anyName": name.text.trim().isEmpty ? '-' : name.text.trim(),
                      "anySurname": sName.text.trim().isEmpty ? '-' : sName.text.trim(),
                    },
                  ),
                );
              },
              child: const Text("Router"))
        ],
      ),
    );
  }
}
