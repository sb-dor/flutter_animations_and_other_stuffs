// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorFloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FloorAppDatabaseBuilder databaseBuilder(String name) =>
      _$FloorAppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FloorAppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$FloorAppDatabaseBuilder(null);
}

class _$FloorAppDatabaseBuilder {
  _$FloorAppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$FloorAppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$FloorAppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<FloorAppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$FloorAppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$FloorAppDatabase extends FloorAppDatabase {
  _$FloorAppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PersonDao? _personDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `persons` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PersonDao get personDao {
    return _personDaoInstance ??= _$PersonDao(database, changeListener);
  }
}

class _$PersonDao extends PersonDao {
  _$PersonDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _personFloorDbModelInsertionAdapter = InsertionAdapter(
            database,
            'persons',
            (PersonFloorDbModel item) =>
                <String, Object?>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PersonFloorDbModel>
      _personFloorDbModelInsertionAdapter;

  @override
  Future<List<PersonFloorDbModel>> getAllPersons() async {
    return _queryAdapter.queryList('select * from persons',
        mapper: (Map<String, Object?> row) => PersonFloorDbModel(
            id: row['id'] as int?, name: row['name'] as String?));
  }

  @override
  Future<PersonFloorDbModel?> getSpecificPerson(int id) async {
    return _queryAdapter.query('select * from persons where id = ?1',
        mapper: (Map<String, Object?> row) => PersonFloorDbModel(
            id: row['id'] as int?, name: row['name'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> delete(int id) async {
    await _queryAdapter
        .queryNoReturn('delete from persons where id = ?1', arguments: [id]);
  }

  @override
  Future<void> insertToDb(PersonFloorDbModel personFloorDbModel) async {
    await _personFloorDbModelInsertionAdapter.insert(
        personFloorDbModel, OnConflictStrategy.abort);
  }
}
