import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/todo_drift_db_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [TodoDriftDbTable])
class AppDatabase extends _$AppDatabase {
  //
  AppDatabase()
      : super(
          driftDatabase(
            name: 'app_database',
            native: const DriftNativeOptions(shareAcrossIsolates: true),
            // to match the location of the files in your project if needed.
            // https://drift.simonbinder.eu/web/#prerequisites
            web: DriftWebOptions(
              sqlite3Wasm: Uri.parse('sqlite3.wasm'),
              driftWorker: Uri.parse('drift_worker.js'),
            ),
          ),
        );

  @override
  int get schemaVersion => 1;
}
