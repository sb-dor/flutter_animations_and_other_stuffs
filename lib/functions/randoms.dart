import 'dart:math';

abstract class Randoms {
  static final random = Random();

  static String randomPictureUrl() {
    final randomInt = random.nextInt(1000);
    return 'https://picsum.photos/seed/$randomInt/300/300';
  }

  static DateTime randomDatetime() {
    final randomDate = Random();
    final currentDate = DateTime.now();
    return currentDate.subtract(Duration(seconds: randomDate.nextInt(200000)));
  }
}
