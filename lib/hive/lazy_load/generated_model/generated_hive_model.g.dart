// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generated_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GeneratedHiveModelAdapter extends TypeAdapter<GeneratedHiveModel> {
  @override
  final int typeId = 1;

  @override
  GeneratedHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GeneratedHiveModel(
      id: fields[0] as String?,
      changeName: fields[1] as String?,
      age: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, GeneratedHiveModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.changeName)
      ..writeByte(2)
      ..write(obj.age);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeneratedHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
