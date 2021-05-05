import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

void sendEmail({String email, String passWord}) async {
  String username = 'flickrteam2@gmail.com';
  String password = 'FlickrFlickr';

  final smtpServer = gmail(username, password);
  // Use the SmtpServer class to configure an SMTP server:
  // final smtpServer = SmtpServer('smtp.domain.com');
  // See the named arguments of SmtpServer for further configuration
  // options.

  // Create our message.
  final message = Message()
    ..from = Address(username, 'Flickr Team')
    ..recipients.add(email)
    ..subject = 'Password Recovery ${DateTime.now()}'
    ..text =
        'user with email $email has requested the password.\nPassowrd is $passWord .';

  var connection = PersistentConnection(smtpServer);
  //await connection.send(message);
  // close the connection
  await connection.close();

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
}
