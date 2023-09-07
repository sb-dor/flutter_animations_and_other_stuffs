import 'dart:math';

abstract class Randoms {
  static final random = Random();

  static String randomPictureUrl({int? width, int? height}) {
    final randomInt = random.nextInt(1000);
    return 'https://picsum.photos/seed/$randomInt/${width ?? 300}/${height ?? 300}';
  }

  static DateTime randomDatetime() {
    final randomDate = Random();
    final currentDate = DateTime.now();
    return currentDate.subtract(Duration(seconds: randomDate.nextInt(200000)));
  }
}
