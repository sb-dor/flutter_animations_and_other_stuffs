import 'package:faker/faker.dart';
import 'package:flutter_animations_2/design_templates/todo_mvvm/models/todo_mvvm.dart';

class TodoMVVMRepository {
  Future<List<TodoMVVM>> getTodos() async {
    final faker = Faker();
    return List.generate(
      30,
      (index) => TodoMVVM(
        todo: faker.lorem.sentence(),
      ),
    );
  }
}
