class RegularExpressions {
  static void regularExpressions() {
    String text = 'The bat took a bite out of the big apple.';

    RegExp exp = RegExp("((@mail)|(@gmail))|((.com)|(.ru))");

    exp.hasMatch("avaz.shams@il.ru");
  }
}
