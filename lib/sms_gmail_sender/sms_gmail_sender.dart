import 'package:flutter/cupertino.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class SmsGmailMessageSender {
  static void sendEmail() async {
    String username = 'your@gmail.com';
    String password = 'youPassword'; // you have two-factor authentication enabled and created an App password.

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Avazsho')
      ..recipients = ['email.address.you.want.to.send@gmail.com']
    // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
    // ..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.';
    // ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";
    //
    try {
      final sendReport = await send(message, smtpServer);
      debugPrint('Message sent: $sendReport');
    } on MailerException catch (e) {
      debugPrint('Message not sent.');
      for (var p in e.problems) {
        debugPrint('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}