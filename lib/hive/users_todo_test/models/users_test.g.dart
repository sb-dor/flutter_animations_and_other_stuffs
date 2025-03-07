// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_test.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UsersTestAdapter extends TypeAdapter<UsersTest> {
  @override
  final int typeId = 3;

  @override
  UsersTest read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UsersTest(
      id: fields[0] as String?,
      name: fields[1] as String?,
      age: fields[2] as int?,
      usersTestTodo: (fields[3] as HiveList?)?.castHiveList(),
    );
  }

  @override
  void write(BinaryWriter writer, UsersTest obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.age)
      ..writeByte(3)
      ..write(obj.usersTestTodo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsersTestAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
