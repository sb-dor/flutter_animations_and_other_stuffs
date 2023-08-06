//Prototype flutter's design patters is just for cloning objects
class Prototype {
  int? id;
  String? name;
  double? value;

  Prototype({this.id, this.name, this.value});

  Prototype clone() => Prototype(id: id, name: name, value: value);
}
