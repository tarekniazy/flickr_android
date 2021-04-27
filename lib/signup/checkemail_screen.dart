import 'package:flickr_android/signup/signupStyling/signup_Widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flickr_android/constants.dart';
import 'signupStyling/signup_BasicLayout.dart';
//import 'package:flutter_html_view/flutter_html_view.dart';

Widget CheckEmailScreen(String mail) {
  String passedEmail = mail;
  SignUpBasicLayout signupBasicLayout = SignUpBasicLayout(CheckEmail(passedEmail));
  return signupBasicLayout;
}

class CheckEmail extends StatefulWidget {
  CheckEmail(this.passedEmail);
  final passedEmail;
  @override
  _CheckEmailState createState() => _CheckEmailState();
}

class _CheckEmailState extends State<CheckEmail> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(25.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            KEmailIcon,
            SizedBox(
              height: 10.0,
            ),
        Text(
          'Check your inbox',
          style: TextStyle(
            fontSize: KLogInToFlickrTextSize,
          ),
        ),

            SizedBox(
              height: 25.0,
            ),
            Text(
              'We sent a verification link to '+ widget.passedEmail + '. Please check your email for the next step.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: KVerificationTextSize,
              ),
            ),

           ],
        ),
      ),
    );
  }
}
