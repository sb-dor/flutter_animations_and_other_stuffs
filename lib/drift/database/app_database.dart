import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'app_database.steps.dart';
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
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          // Run migration steps without foreign keys and re-enable them later
          // (https://drift.simonbinder.eu/docs/advanced-features/migrations/#tips)
          await customStatement('PRAGMA foreign_keys = OFF');
          //
          await m.runMigrationSteps(
            from: from,
            to: to,
            steps: migrationSteps(
              from1To2: (m, schema) async {
                //
              },
              from2To3: (m, schema) async {
                await m.addColumn(todoDriftDbTable, todoDriftDbTable.content);
              },
              from3To4: (Migrator m, Schema4 schema) async {
                await m.addColumn(todoDriftDbTable, todoDriftDbTable.author);
              },
              from4To5: (Migrator m, Schema5 schema) async {
                await m.alterTable(
                  TableMigration(
                    todoDriftDbTable,
                    columnTransformer: {
                      todoDriftDbTable.createdAt: todoDriftDbTable.createdAt.cast<String>(),
                    },
                  ),
                );
              },
            ),
          );
        },
      );

  @override
  int get schemaVersion => 5;
}
