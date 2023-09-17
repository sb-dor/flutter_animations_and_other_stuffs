import 'package:equatable/equatable.dart';

class EquatableModel extends Equatable {
  final int? id;
  final String? name;
  final int? age;

  const EquatableModel({this.id, this.name, this.age});

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, age];
}
