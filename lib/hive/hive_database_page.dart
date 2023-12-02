import 'package:flutter/material.dart';
import 'package:flutter_animations_2/hive/hive_database_helper.dart';

class HiveDatabasePage extends StatefulWidget {
  const HiveDatabasePage({Key? key}) : super(key: key);

  @override
  State<HiveDatabasePage> createState() => _HiveDatabasePageState();
}

class _HiveDatabasePageState extends State<HiveDatabasePage> {
  HiveDatabaseHelper hiveDatabaseHelper = HiveDatabaseHelper.instance;
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    var data = await hiveDatabaseHelper.getFromBox(boxName: 'table1');
    if (data.isEmpty) return;
    var f = data.first;
    _counter = f['counter_value'];
    setState(() {});
  }

  void addValue(bool minus) async {
    var data = await hiveDatabaseHelper.getFromBox(boxName: 'table1');
    if (data.isNotEmpty) {
      var lastValue = _counter;
      _counter = minus ? _counter - 1 : _counter++;
      await hiveDatabaseHelper.update(
          boxName: 'table1',
          key: 'counter_value',
          value: lastValue,
          updatingValue: {"counter_value": _counter});
    } else {
      _counter = minus ? _counter - 1 : _counter++;
      await hiveDatabaseHelper.insert(boxName: 'table1', value: {'counter_value': _counter});
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hive")),
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Counter _$_counter"),
              ElevatedButton(onPressed: () => addValue(false), child: const Text("Plus")),
              ElevatedButton(onPressed: () => addValue(true), child: const Text("Minus")),
            ]),
      ),
    );
  }
}
