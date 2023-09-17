class DatabaseModel {
  int? id;
  String? name;
  int? age;

  DatabaseModel({this.id, this.name, this.age});

  factory DatabaseModel.fromDb(Map<String, dynamic> db) =>
      DatabaseModel(id: db['id'], name: db['name'], age: db['age']);

  Map<String, dynamic> toMap() => {'name': name, "age": age};
}
