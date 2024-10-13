import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

// about adapters:
// https://youtu.be/2caSU_2kGc4?list=PLrnbjo4fMQwYxZMrbyweTFaOTmMbZEx1z&t=1702

class TodoHive {
  final String? id;
  final String? todo;

  TodoHive({required this.id, required this.todo});

  factory TodoHive.fromHive(Map<dynamic, dynamic> json) {
    return TodoHive(
      id: json['id'] as String?,
      todo: json['todo'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "todo": todo,
    };
  }

  @override
  String toString() {
    return "Todo id: $id, todo: $todo";
  }
}

class TodoHiveAdapter extends TypeAdapter<TodoHive> {
  @override
  TodoHive read(BinaryReader reader) {
    return TodoHive.fromHive(reader.readMap());
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, TodoHive obj) {
    writer.writeMap(obj.toMap());
  }
}
