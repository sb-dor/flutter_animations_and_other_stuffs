import 'package:flutter/material.dart';
import 'package:flutter_animations_2/flutter_secure_storage/flutter_secure_storage_helper.dart';

class FlutterSecureStoragePage extends StatefulWidget {
  const FlutterSecureStoragePage({super.key});

  @override
  State<FlutterSecureStoragePage> createState() => _FlutterSecureStoragePageState();
}

class _FlutterSecureStoragePageState extends State<FlutterSecureStoragePage> {
  final _secureStorage = SecureStorageHelper.internal;

  int value = 0;

  @override
  void initState() {
    super.initState();
    _secureStorage.init();
    _getValue();
  }

  void _getValue() async {
    value = int.tryParse("${await _secureStorage.getByKey('int_ss')}") ?? 0;
    setState(() {});
  }

  Future<void> _saveInStorage() async {
    await _secureStorage.saveByKey('int_ss', value.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter secure storage"),
      ),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                value++;
                await _saveInStorage();
                setState(() {});
              },
              child: const Text("increment"),
            ),
            Text("$value"),
            ElevatedButton(
              onPressed: () async {
                value--;
                await _saveInStorage();
                setState(() {});
              },
              child: const Text("decrement"),
            ),
          ],
        ),
      ),
    );
  }
}
