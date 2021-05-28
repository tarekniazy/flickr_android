import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flickr_android/constants.dart';
import 'signupStyling/signup_BasicLayout.dart';
import 'signupStyling/signup_Widgets.dart';


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
bool emailSent=false;

  @override
  Widget build(BuildContext context) {
    var _onPressed;

    if (emailSent==false){
      _onPressed = () {
        setState(() {
          emailSent=true;

        });
      };
      }

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
            fontFamily: 'Frutiger',
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

            SizedBox(
              height: 40.0,
            ),

            Container(
              height: 45.0,
              width: double.infinity,
              child: TextButton(
                onPressed: _onPressed,
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all(emailSent == true ? KFlickrNormalGreyColor : KFlickrNormalBlueColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
                child: Row (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [

                Visibility(
                visible: (emailSent == true) ? true : false,
                        child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget> [
                          kCorrectIcon,
                      ],
                ),
                ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(emailSent == true ? 'Email sent.' : 'Resend email',
                    style: TextStyle(
                      color: emailSent == true ? kEmailGreyColor : Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
              ],
                ),
              ),
            ), // Sign up button
           ],
        ),
      ),
    );
  }
}