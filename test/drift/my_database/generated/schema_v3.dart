// dart format width=80
// GENERATED CODE, DO NOT EDIT BY HAND.
// ignore_for_file: type=lint
import 'package:drift/drift.dart';

class TodoDriftDbTable extends Table
    with TableInfo<TodoDriftDbTable, TodoDriftDbTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  TodoDriftDbTable(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, name, content, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'todo_drift_db_table';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TodoDriftDbTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TodoDriftDbTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
    );
  }

  @override
  TodoDriftDbTable createAlias(String alias) {
    return TodoDriftDbTable(attachedDatabase, alias);
  }
}

class TodoDriftDbTableData extends DataClass
    implements Insertable<TodoDriftDbTableData> {
  final int id;
  final String name;
  final String? content;
  final DateTime? createdAt;
  const TodoDriftDbTableData(
      {required this.id, required this.name, this.content, this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String>(content);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    return map;
  }

  TodoDriftDbTableCompanion toCompanion(bool nullToAbsent) {
    return TodoDriftDbTableCompanion(
      id: Value(id),
      name: Value(name),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory TodoDriftDbTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TodoDriftDbTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      content: serializer.fromJson<String?>(json['content']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'content': serializer.toJson<String?>(content),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
    };
  }

  TodoDriftDbTableData copyWith(
          {int? id,
          String? name,
          Value<String?> content = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent()}) =>
      TodoDriftDbTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        content: content.present ? content.value : this.content,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
      );
  TodoDriftDbTableData copyWithCompanion(TodoDriftDbTableCompanion data) {
    return TodoDriftDbTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      content: data.content.present ? data.content.value : this.content,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TodoDriftDbTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, content, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TodoDriftDbTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.content == this.content &&
          other.createdAt == this.createdAt);
}

class TodoDriftDbTableCompanion extends UpdateCompanion<TodoDriftDbTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> content;
  final Value<DateTime?> createdAt;
  const TodoDriftDbTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.content = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TodoDriftDbTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.content = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<TodoDriftDbTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? content,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (content != null) 'content': content,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TodoDriftDbTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? content,
      Value<DateTime?>? createdAt}) {
    return TodoDriftDbTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodoDriftDbTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class DatabaseAtV3 extends GeneratedDatabase {
  DatabaseAtV3(QueryExecutor e) : super(e);
  late final TodoDriftDbTable todoDriftDbTable = TodoDriftDbTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [todoDriftDbTable];
  @override
  int get schemaVersion => 3;
}
