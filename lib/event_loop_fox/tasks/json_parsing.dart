import 'dart:convert';
import 'dart:io';
import 'dart:math';

void main() async {
  final file = File('large_users.json');
  final sink = file.openWrite();
  final random = Random();

  List<String> countries = ['USA', 'Germany', 'India', 'Brazil', 'Japan'];

  sink.write('{"users": [');

  for (int i = 1; i <= 100000; i++) {
    final user = {
      "id": i,
      "name": "User $i",
      "email": "user$i@example.com",
      "age": random.nextInt(73) + 18, // age between 18 and 90
      "country": countries[random.nextInt(countries.length)],
      "bio": "This is a sample bio for user $i. " * 3,
      "active": random.nextBool()
    };

    sink.write(jsonEncode(user));
    if (i < 100000) sink.write(',');
  }

  sink.write(']}');
  await sink.flush();
  await sink.close();

  print('JSON file created!');
}