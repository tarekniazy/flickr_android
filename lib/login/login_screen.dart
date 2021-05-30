import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flickr_android/constants.dart';
import 'loginStyling/login_Widgets.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flickr_android/enums.dart';
import 'forgortPW_screen.dart';
import 'loginStyling/login_BasicLayout.dart';
import '../Services/networking.dart';
import 'dart:convert';
import '../home/home.dart';
import '../signup/signup_screen.dart';

Widget LoggingInScreen() {
  LoginBasicLayout loginBasicLayout = LoginBasicLayout(Login());
  return loginBasicLayout;
}

String userToken;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  EnumError errorEmail = EnumError.hide;
  EnumError errorPassword = EnumError.hide;
  int logInID = 135;
  bool visibility = false;
  bool _hiddenText = true;
  bool _emailPWInvalidText = false;
  String buttonText = 'Next';
  String email;
  String password;

  void changeButtonTextToSignIn() {
    buttonText = 'Sign in';
  }

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
          //TODO arwa- Redirect to yahoo page
          color: Colors.grey,
        ),
        DialogButton(
          child: Text(
            "Try again",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          // onPressed: () =>
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
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
            Visibility(
              //TODO arwa- assign visibilty according to wether the email has a flutter account or not
              visible: _emailPWInvalidText,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  kClipRRect,
                ],
              ),
            ), // warning sign
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
                  errorText: (errorPassword == EnumError.show)
                      ? "Invalid password"
                      : null,
                  labelText: 'Password',
                  focusedBorder: KOutlineInputBorderFocused,
                  border: KOutlineInputBorder,
                ),
              ),
            ), //Password Text field
            SizedBox(height: 25.0),
            Container(
              height: 40.0,
              width: double.infinity,
              child: TextButton(
                onPressed: () async {
                  if (buttonText == 'Next') {
                    emailChecking();
                    if (visibility == true) {
                      setState(() {
                        changeButtonTextToSignIn();
                      });
                    }
                  } else if (password != null) {
                    Map<String, dynamic> Body = {
                      "email": email,
                      "password": password
                    };

                    // //TODO arwa- when the button's text == sign in, NOTE( text == next is done)
                    // //TODO arwa- Edit in Next phases
                    setState(() {
                      // if (email == "Arwa@gmail.com" || password == "flickr") {
                      //   if (email != "Arwa@gmail.com") {
                      //     _emailPWInvalidText = true;
                      //   } else if (password != "flickr") {
                      //     errorPassword = EnumError.show;
                      //     _emailPWInvalidText = false;
                      //   } else {
                      //     logInID = 134;
                      //     _emailPWInvalidText = false;
                      //   }
                      // } else {
                      //   _emailPWInvalidText = true;
                      // }
                    });

                    // 200 for ID=134 , 500 for ID=135
                    NetworkHelper req =
                        new NetworkHelper("$KBaseUrl/user/login");
                    var res = await req.postData(Body);
                    print(Body);
                    if (res.statusCode == 200) {
                      setState(() {
                        _emailPWInvalidText = false;
                      });

                      print(jsonDecode(res.body)["token"]);

                      userToken = jsonDecode(res.body)["token"];

                      NetworkHelper req2 =
                          new NetworkHelper("$KMockSeverBaseUrl/image/explore");
                      var res2 = await req2.getData();
                      print(res2.statusCode);
                      if (res2.statusCode == 200) {
                        String data2 = res2.body;
                        List<dynamic> response2 = jsonDecode(data2);

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Home(
                            exploreImages: response2,
                          );
                        }));
                      } else {
                        print(res2.statusCode);
                      }
                    } else if (res.statusCode == 404) {
                      setState(() {
                        _emailPWInvalidText = true;
                        errorPassword = EnumError.hide;
                      });
                    } else {
                      errorPassword = EnumError.show;
                      _emailPWInvalidText = false;
                      print(res.statusCode);
                    }
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
                  buttonText,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ), // Next/SignIn button
            Visibility(
              visible: (visibility == true) ? true : false,
              child: Column(
                children: <Widget>[
                  TextButton(
                    child: Text(
                      'Forgot password?',
                      style: KHyperlinkedTexts,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ForgotPassWordScreen(email);
                          },
                        ),
                      );
                    },
                  ),
                  Divider(
                    color: Colors.grey,
                  )
                ],
              ),
            ), // Forgot password? and divider
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Not a Flickr member?'),
                TextButton(
                  onPressed: () {
                    // TODO// @mariam- your sign up screen here
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignUpScreen(); //TODO//;
                        },
                      ),
                    );
                  },
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
