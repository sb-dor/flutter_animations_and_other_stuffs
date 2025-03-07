import 'package:flutter/material.dart';
import 'package:flutter_animations_2/sqflite/model/database_model.dart';
import 'package:flutter_animations_2/sqflite/sqflite_database_helper.dart';

class SqfliteDatabasePage extends StatefulWidget {
  const SqfliteDatabasePage({super.key});

  @override
  State<SqfliteDatabasePage> createState() => _SqfliteDatabasePageState();
}

class _SqfliteDatabasePageState extends State<SqfliteDatabasePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SqfLiteDatabaseHelper.initStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter Sqflite with streams")),
      body: Column(children: [
        const SizedBox(height: 20),
        StreamBuilder<List<DatabaseModel>>(
            stream: SqfLiteDatabaseHelper.databaseModelStream,
            builder: (context, stream) => Expanded(
                child: ListView.separated(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                    itemCount: stream.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Text('${stream.data?[index].name}');
                    }))),
        Row(children: [
          ElevatedButton(
              onPressed: () => SqfLiteDatabaseHelper.addDatabaseModel(), child: const Text("Add")),
          const SizedBox(width: 50),
          ElevatedButton(
              onPressed: () => SqfLiteDatabaseHelper.deleteLast(),
              child: const Text("Remove last")),
        ])
      ]),
    );
  }
}
