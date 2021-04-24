import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flickr_android/constants.dart';
import 'loginStyling/login_Widgets.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flickr_android/enums.dart';

Widget loggingin() {
  return MaterialApp(
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
  );
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  EnumError errorEmail = EnumError.hide;
  EnumError errorPassword = EnumError.hide;
  bool visibility = false;
  bool _hiddenText = true;
  String email;
  String password;

  void toggleHiddenText() {
    setState(() {
      _hiddenText = !_hiddenText;
    });
  }

  // Creates a popup alert
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

  // Parameter : Valid/Invalid mail , Functionality : calls popup message to alert the user when email is invalid
  void isMail(EnumEmail mail) {
    if (mail == EnumEmail.valid) {
      setState(() {
        errorEmail = EnumError.hide;
      });
    } else {
      popupMessage();
    }
  }

  // Checks the String email, and performs the suitable action accordingly
  void emailChecking() {
    if (email?.isNotEmpty ?? false) {
      final bool isValid = EmailValidator.validate(email);
      isValid ? isMail(EnumEmail.valid) : isMail(EnumEmail.invalid);
      if (isValid == true) {
        setState(() {
          visibility = true;
        });
      }
    } else if (email?.isEmpty ?? true) {
      setState(
        () {
          errorEmail = EnumError.show;
        },
      );
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
            ), // Flickr Icon and Log in to flickr
            SizedBox(height: 20.0),
            TextField(
              onChanged: (value) {
                email = value;
              },
              decoration: InputDecoration(
                errorText: (errorEmail == EnumError.show) ? "Required" : null,
                labelText: 'Email address',
                focusedBorder: KOutlineInputBorderFocused,
                border: KOutlineInputBorder,
              ),
            ), //Email Text field
            SizedBox(height: 10.0),
            Visibility(
              visible: (visibility == true) ? true : false,
              child: TextFormField(
                obscureText: _hiddenText,
                onChanged: (value) {
                  password = value;
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      toggleHiddenText();
                    },
                    icon: (_hiddenText)
                        ? Icon(
                            Icons.remove_red_eye_outlined,
                          )
                        : Icon(Icons.visibility_off_outlined),
                  ),
                  errorText:
                      (errorPassword == EnumError.show) ? "Required" : null,
                  labelText: 'Password',
                  focusedBorder: KOutlineInputBorderFocused,
                  border: KOutlineInputBorder,
                ),
              ),
            ), //Password Text field
            SizedBox(height: 35.0),
            Container(
              height: 40.0,
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  emailChecking();
                  print(visibility);
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
                  (visibility == false) ? 'Next' : 'Sign in',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ), // Next/SignIn button
            SizedBox(height: 20.0),
            Visibility(
              visible: (visibility == true) ? true : false,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    child: Text(
                      'Forgot password?',
                      style: KHyperlinkedTexts,
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Divider(
                    color: Colors.grey,
                  )
                ],
              ),
            ), // Forgot password? and divider
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Not a Flickr member?'),
                GestureDetector(
                  onTap: () {},
                  child: Text(' Sign up here', style: KHyperlinkedTexts),
                ),
              ],
            ), // Not a flickr member? SignUp here
          ],
        ),
      ),
    );
  }
}
