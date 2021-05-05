import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flickr_android/constants.dart';
import 'signupStyling/signup_BasicLayout.dart';
import 'signupStyling/signup_Widgets.dart';
import '../login/login_screen.dart';


Widget emailVerifiedScreen() {
  SignUpBasicLayout signupBasicLayout = SignUpBasicLayout(EmailVerified());
  return signupBasicLayout;
}

class EmailVerified extends StatefulWidget {
  @override
  _EmailVerifiedState createState() => _EmailVerifiedState();
}

class _EmailVerifiedState extends State<EmailVerified> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(25.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            kCorrectIconLarge,
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Email Verified!',
              style: TextStyle(
                fontSize: KLogInToFlickrTextSize,
              ),
            ),

            SizedBox(
              height: 22.0,
            ),

            Text(
              'For security purposes, you\'ll need to sign in.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: KVerificationTextSize,
              ),
            ),

            SizedBox(
              height: 17.0,
            ),

            Container(
              height: 40.0,
              width: double.infinity,
              child: TextButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoggingInScreen();
                      },
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all(KFlickrNormalBlueColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
                child: Text('Okay, got it!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
              ),
            ),
                  ],
                ),
    ),
    );
  }
}