import 'package:flutter_test/flutter_test.dart';

void main() {
  group('regex_test', () {
    test('first_test', () {
      RegExp exp = RegExp("((@mail)|(@gmail))|((.com)|(.ru))");

      String text = 'bdnabd@gmail.com';

      bool check = exp.hasMatch(text);

      expect(true, check);
    });

    test('second_test', () {
      RegExp exp = RegExp("@(mail|gmail).(com|ru)");

      String text = 'honaiama@fox.ru';

      bool check = exp.hasMatch(text);


      expect(false, check);
    });
  });
}
