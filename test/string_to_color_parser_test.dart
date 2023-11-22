import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

void main() {
  (int first, int second, int third) rgbColor({required String color}) {
    int? firstValue;
    int? secondValue;
    int? thirdValue;
    String firstValueString = '';
    String secondValueString = '';
    String thirdValueString = '';
    int firstIndex = color.indexOf(',');
    int thirdIndex = color.lastIndexOf(',');
    for (int i = firstIndex; i >= 0; i--) {
      if (int.tryParse(color[i]) != null) firstValueString += color[i];
    }
    firstValueString = firstValueString.split('').reversed.join();
    for (int i = thirdIndex; i >= firstIndex; i--) {
      if (int.tryParse(color[i]) != null) secondValueString += color[i];
    }
    secondValueString = secondValueString.split('').reversed.join();
    for (int i = thirdIndex; i < color.length; i++) {
      if (int.tryParse(color[i]) != null) thirdValueString += color[i];
    }
    //
    firstValue = int.tryParse(firstValueString.trim()) ?? 0;
    secondValue = int.tryParse(secondValueString.trim()) ?? 0;
    thirdValue = int.tryParse(thirdValueString.trim()) ?? 0;
    return (firstValue, secondValue, thirdValue);
  }

  group('group-string-to-color-test', () {
    test('first-test', () {
      String color = 'rgb(0, 0, 0)';

      var res = rgbColor(color: color);

      expect(Color.fromRGBO(res.$1, res.$2, res.$3, 1), const Color.fromRGBO(0, 0, 0, 1));
    });
    //
    test('second-test', () {
      String color = 'rgb(193, 193, 193)';

      var res = rgbColor(color: color);

      expect(Color.fromRGBO(res.$1, res.$2, res.$3, 1), const Color.fromRGBO(193, 193, 193, 1));
    });
    //
    test('third-test', () {
      String color = 'rgb(255, 255, 255)';

      var res = rgbColor(color: color);

      expect(Color.fromRGBO(res.$1, res.$2, res.$3, 1), const Color.fromRGBO(255, 255, 255, 1));
    });
    //
    test('fourth-test', () {
      String color = 'rgb(156, 153, 153)';

      var res = rgbColor(color: color);

      expect(Color.fromRGBO(res.$1, res.$2, res.$3, 1), const Color.fromRGBO(156, 153, 153, 1));
    });
    //
    test('fifth-test', () {
      String color = 'rgb(51, 77, 255)';

      var res = rgbColor(color: color);

      expect(Color.fromRGBO(res.$1, res.$2, res.$3, 1), const Color.fromRGBO(51, 77, 255, 1));
    });
    //
    test('sixth-test', () {
      String color = 'rgb(252, 72, 41)';

      var res = rgbColor(color: color);

      expect(Color.fromRGBO(res.$1, res.$2, res.$3, 1), const Color.fromRGBO(252, 72, 41, 1));
    });
    //
    test('seventh-test', () {
      String color = 'rgb(53, 186, 43)';

      var res = rgbColor(color: color);

      expect(Color.fromRGBO(res.$1, res.$2, res.$3, 1), const Color.fromRGBO(53, 186, 43, 1));
    });
    //
    test('eighth-test', () {
      String color = 'rgb(146, 101, 71)';

      var res = rgbColor(color: color);

      expect(Color.fromRGBO(res.$1, res.$2, res.$3, 1), const Color.fromRGBO(146, 101, 71, 1));
    });
    //
    test('ninth-test', () {
      String color = 'rgb(241, 217, 178)';

      var res = rgbColor(color: color);

      expect(Color.fromRGBO(res.$1, res.$2, res.$3, 1), const Color.fromRGBO(241, 217, 178, 1));
    });
    //
    test('tenth-test', () {
      String color = 'rgb(54, 161, 255)';

      var res = rgbColor(color: color);

      expect(Color.fromRGBO(res.$1, res.$2, res.$3, 1), const Color.fromRGBO(54, 161, 255, 1));
    });
    //
    test('eleventh-test', () {
      String color = 'rgb(250, 190, 0)';

      var res = rgbColor(color: color);

      expect(Color.fromRGBO(res.$1, res.$2, res.$3, 1), const Color.fromRGBO(250, 190, 0, 1));
    });
    //
    test('twelfth-test', () {
      String color = 'rgb(197, 23, 45)';

      var res = rgbColor(color: color);

      expect(Color.fromRGBO(res.$1, res.$2, res.$3, 1), const Color.fromRGBO(197, 23, 45, 1));
    });
    //
    test('thirteenth-test', () {
      String color = 'rgb(153, 102, 204)';

      var res = rgbColor(color: color);

      expect(Color.fromRGBO(res.$1, res.$2, res.$3, 1), const Color.fromRGBO(153, 102, 204, 1));
    });
    //
    test('fourteenth-test', () {
      String color = 'rgb(253, 233, 15)';

      var res = rgbColor(color: color);

      expect(Color.fromRGBO(res.$1, res.$2, res.$3, 1), const Color.fromRGBO(253, 233, 15, 1));
    });
    //
    test('fifteenth-test', () {
      String color = 'rgb(255, 153, 102)';

      var res = rgbColor(color: color);

      expect(Color.fromRGBO(res.$1, res.$2, res.$3, 1), const Color.fromRGBO(255, 153, 102, 1));
    });
    //
    test('sixteenth-test', () {
      String color = 'rgb(255, 192, 203)';

      var res = rgbColor(color: color);

      expect(Color.fromRGBO(res.$1, res.$2, res.$3, 1), const Color.fromRGBO(255, 192, 203, 1));
    });
  });
}
