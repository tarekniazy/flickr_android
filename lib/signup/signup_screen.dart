import 'emailverified_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flickr_android/constants.dart';
import 'package:flutter/rendering.dart';
import 'signupStyling/signup_Widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:g_captcha/g_captcha.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flickr_android/enums.dart';
import '../login/login_screen.dart';
import 'signupStyling/signup_BasicLayout.dart';
import 'checkemail_screen.dart';
import '../Services/networking.dart';

Widget SignUpScreen() {
  SignUpBasicLayout signupBasicLayout = SignUpBasicLayout(SignUp());
  return signupBasicLayout;
}

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  EnumError errorEmail = EnumError.hide;
  EnumError errorPassword = EnumError.hide;
  EnumError errorFirstName = EnumError.hide;
  EnumError errorLastName = EnumError.hide;
  EnumError errorAge = EnumError.hide;
  bool _hiddenText = true;
  String email;
  String password;
  String firstName;
  String lastName;
  String age;
  String ageErrorText;
  String passwordErrorText;
  String emailErrorText;
  bool checkBoxValue = false;
  bool checkBoxRed = false;

  _openReCaptcha() async {
    String tokenResult = await GCaptcha.reCaptcha(CAPTCHA_SITE_KEY);
    print('tokenResult: $tokenResult');
    Fluttertoast.showToast(msg: tokenResult, timeInSecForIosWeb: 4);
  }

  void checkBoxChecker() {
    if (checkBoxValue == false) {
      checkBoxRed = true;
    } else
      checkBoxRed = false;
  }

  void toggleHiddenText() {
    setState(() {
      _hiddenText = !_hiddenText;
    });
  }

  bool isPassword(String password) {
    if (password.length >= 12) {
      var str = password.trim();
      if (identical(password, str))
        return true;
      else
        return false;
    } else
      return false;
  }

  // Checks the String email, and performs the suitable action accordingly
  void emailChecking() {
    if (email?.isNotEmpty ?? false) {
      final bool isValid = EmailValidator.validate(email);
      if (isValid == true) {
        setState(() {
          errorEmail = EnumError.hide;
        });
      } else if (isValid == false) {
        setState(() {
          errorEmail = EnumError.show;
          emailErrorText = "Invalid email";
        });
      }
    } else if (email?.isEmpty ?? true) {
      setState(
        () {
          errorEmail = EnumError.show;
          emailErrorText = "Required";
        },
      );
    }
  }

  void firstNameChecking() {
    if (firstName?.isNotEmpty ?? false) {
      setState(() {
        errorFirstName = EnumError.hide;
      });
    } else if (firstName?.isEmpty ?? true) {
      setState(
        () {
          errorFirstName = EnumError.show;
        },
      );
    }
  }

  void lastNameChecking() {
    if (lastName?.isNotEmpty ?? false) {
      setState(() {
        errorLastName = EnumError.hide;
      });
    } else if (lastName?.isEmpty ?? true) {
      setState(
        () {
          errorLastName = EnumError.show;
        },
      );
    }
  }

  void ageChecking() {
    if (age?.isNotEmpty ?? false) {
      setState(() {
        final ageNumber =
            num.tryParse(age); //to check if the string can be numeric or not
        if (ageNumber == null) {
          errorAge = EnumError.show;
          ageErrorText = "Invalid age";
        } else {
          if (ageNumber < 0 || ageNumber > 120) {
            errorAge = EnumError.show;
            ageErrorText = "Invalid age";
          } else if (ageNumber >= 0 && ageNumber < 13) {
            errorAge = EnumError.show;
            ageErrorText = "In order to use Flickr, you must be 13 or older";
          } else {
            errorAge = EnumError.hide;
          }
        }
      });
    } else if (age?.isEmpty ?? true) {
      setState(
        () {
          errorAge = EnumError.show;
          ageErrorText = "Required";
        },
      );
    }
  }

  void passwordChecking() {
    if (password?.isNotEmpty ?? false) {
      setState(() {
        if (isPassword(password))
          errorPassword = EnumError.hide;
        else {
          errorPassword = EnumError.show;
          passwordErrorText =
              "Please use at least: 12 characters and no leading spaces";
        }
      });
    } else if (password?.isEmpty ?? true) {
      setState(
        () {
          errorPassword = EnumError.show;
          passwordErrorText = "Required";
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
          children: <Widget>[
            KFlickrIcon,
            SizedBox(height: 20.0),
            Text(
              'Sign Up for Flickr',
              style: TextStyle(
                fontSize: KLogInToFlickrTextSize,
              ),
            ), // Flickr Icon and Sign Up for flickr
            Visibility(
              //TODO mariam- assign visibilty according to wether the email has a flutter account or not
              visible: false,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  kClipRRect,
                ],
              ),
            ), // warning sign
            SizedBox(height: 20.0),
            TextField(
              onChanged: (valueFirstName) {
                firstName = valueFirstName;
              },
              decoration: InputDecoration(
                errorText:
                    (errorFirstName == EnumError.show) ? "Required" : null,
                labelText: 'First name',
                focusedBorder: KOutlineInputBorderFocused,
                border: KOutlineInputBorder,
              ),
            ), //First Name Text field
            SizedBox(height: 10.0),

            TextField(
              onChanged: (valueLastName) {
                lastName = valueLastName;
              },
              decoration: InputDecoration(
                errorText:
                    (errorLastName == EnumError.show) ? "Required" : null,
                labelText: 'Last name',
                focusedBorder: KOutlineInputBorderFocused,
                border: KOutlineInputBorder,
              ),
            ), //Email Text field
            SizedBox(height: 10.0),

            TextField(
              onChanged: (valueAge) {
                age = valueAge;
              },
              decoration: InputDecoration(
                errorText: (errorAge == EnumError.show) ? ageErrorText : null,
                labelText: 'Your age',
                focusedBorder: KOutlineInputBorderFocused,
                border: KOutlineInputBorder,
              ),
            ), //Email Text field
            SizedBox(height: 10.0),

            TextField(
              onChanged: (valueEmail) {
                email = valueEmail;
              },
              decoration: InputDecoration(
                errorText:
                    (errorEmail == EnumError.show) ? emailErrorText : null,
                labelText: 'Email address',
                focusedBorder: KOutlineInputBorderFocused,
                border: KOutlineInputBorder,
              ),
            ), //Email Text field
            SizedBox(height: 10.0),

            TextFormField(
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
                    ? passwordErrorText
                    : null,
                labelText: 'Password',
                focusedBorder: KOutlineInputBorderFocused,
                border: KOutlineInputBorder,
              ),
            ), //Password Text field
            SizedBox(height: 10.0),

            Container(
              height: 60.0,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Row(
                children: <Widget>[
                  Theme(
                    data: ThemeData(
                        unselectedWidgetColor:
                            (checkBoxRed) ? Colors.red : Colors.grey),
                    child: Checkbox(
                      value: checkBoxValue,
                      onChanged: (bool newValue) {
                        setState(() {
                          checkBoxValue = newValue;
                          if (newValue == true) {
                            _openReCaptcha();
                          }
                        });
                      },
                    ),
                  ),
                  Text(
                    'I\'m not a robot',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Image.asset(
                          'images/recaptcha.png',
                          height: 50,
                          width: 50,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 25.0),

            Container(
              height: 40.0,
              width: double.infinity,
              child: TextButton(
                onPressed: () async {
                  emailChecking();
                  firstNameChecking();
                  lastNameChecking();
                  ageChecking();
                  passwordChecking();
                  checkBoxChecker();

                  Map<String, dynamic> Body = {
                    "firstName": firstName,
                    "lastName": lastName,
                    "email": email,
                    "password": password,
                    "age": age
                  };

                  if (errorEmail == EnumError.hide &&
                      errorFirstName == EnumError.hide &&
                      errorLastName == EnumError.hide &&
                      errorAge == EnumError.hide &&
                      errorPassword == EnumError.hide &&
                      checkBoxValue == true) {

                    NetworkHelper req = new NetworkHelper(
                        "$KBaseUrl/v3/signup?id=44");

                    var res = await req.postData(Body);

                    if (res.statusCode == 200) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) {
                              return CheckEmailScreen(email);
                             // return emailVerifiedScreen();
                            }
                        ),
                      );
                    }
                    else if (res.statusCode == 422) {
                      emailErrorText = 'Email unavailable';

                    }
                    else if (res.statusCode == 500) {
                      emailErrorText = 'Failed to create user';
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
                  'Sign up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ), // Sign up button

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Already a Flickr member?'),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoggingInScreen();
                        },
                      ),
                    );
                  },
                  child: Text(' Log in here', style: KHyperlinkedTexts),
                ),
              ],
            ), // Already a flickr member? Log in here
          ],
        ),
      ),
    );
  }
}
