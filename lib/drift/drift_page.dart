import 'package:flutter/material.dart';
import 'package:flutter_animations_2/drift/database/app_database.dart';
import 'package:provider/provider.dart';

import 'database/database_helper.dart';

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
  final appDatabase = AppDatabase();

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
  late final DealWithDatabase _dealWithDatabase;

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dealWithDatabase = DealWithDatabase(
      Provider.of<Dependencies>(context).appDatabase,
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App with drift"),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
