import 'package:flutter/material.dart';
import 'package:flutter_animations_2/handling_errors/handing_errors.dart';
import 'package:flutter_animations_2/handling_errors/log_model.dart';
import 'package:flutter_animations_2/hive/lazy_load/hive_settings.dart';

class HandlingErrorPage extends StatefulWidget {
  const HandlingErrorPage({super.key});

  @override
  State<HandlingErrorPage> createState() => _HandlingErrorPageState();
}

class _HandlingErrorPageState extends State<HandlingErrorPage> {
  final _handlingError = HandlingErrorsModule.internal;
  final _hive = HiveSettings.internal;

  List<LogModel> logs = [];

  @override
  void initState() {
    super.initState();
    _handlingError.setUpLogging();
    _handlingError.handlingError();
    _handlingError.mockErrors();
    getLogs();
  }

  void getLogs() async {
    logs = await _hive.getLogs();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Handling errors: ${logs.length}"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          getLogs();
        },
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: logs.length,
          itemBuilder: (context, index) {
            final log = logs[index];
            return ListTile(
              title: Text(log.message ?? ''),
              subtitle: Text(log.timeOfError ?? ''),
            );
          },
        ),
      ),
    );
  }
}
