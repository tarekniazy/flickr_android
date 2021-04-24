import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flickr_android/constants.dart';
import 'loginStyling/login_Widgets.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flickr_android/enums.dart';

void main() {
  runApp(
    MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: KAppBarBackgroundColor,
            title: Row(
              children: <Widget>[
                KFlickrIcon,
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  'flickr',
                  style: KFlickrTextStyle,
                ),
              ],
            ),
          ),
          body: Login(),
          bottomNavigationBar: Text('hi'),
        ),
      ),
    ),
  );
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  EnumError error = EnumError.hide;
  String email;

  void popupMessage() {
    Alert(
      context: context,
      style: AlertStyle(
          overlayColor: KPopupOverlayColor,
          isCloseButton: false,
          alertBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(2),
            ),
          )),
      title: KPopupMessageTitle,
      desc: KPopupMessageBody,
      buttons: [
        DialogButton(
          child: Text(
            "Continue to Yahoo",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          onPressed: () => Navigator.pop(context),
          color: Colors.grey,
        ),
        DialogButton(
          child: Text(
            "Try again",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          onPressed: () => Navigator.pop(context),
          color: KFlickrNormalBlueColor,
        )
      ],
    ).show();
  }

  void isMail(EnumEmail mail) {
    if (mail == EnumEmail.valid) {
    } else {
      popupMessage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(25.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            KFlickrIcon,
            SizedBox(height: 20.0),
            Text(
              'Log in to Flickr',
              style: TextStyle(
                fontSize: KLogInToFlickrTextSize,
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              onChanged: (value) {
                email = value;
                print(email.length);
                print(email.isEmpty);
              },
              decoration: InputDecoration(
                errorText: (error == EnumError.show) ? "Required" : null,
                labelText: 'Email address',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.8,
                    color: KFlickrNormalBlueColor,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
              ),
            ),
            SizedBox(height: 35.0),
            Container(
              height: 40.0,
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  if (email?.isNotEmpty ?? false) {
                    final bool isValid = EmailValidator.validate(email);
                    isValid
                        ? isMail(EnumEmail.valid)
                        : isMail(EnumEmail.invalid);
                  } else if (email?.isEmpty ?? true) {
                    setState(() {
                      error = EnumError.show;
                    });
                  }
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
                child: Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Not a Flickr member?'),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Sign up here',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
