import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flickr_android/constants.dart';
import 'signupStyling/signup_Widgets.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flickr_android/enums.dart';
import '../login/login_screen.dart';
import 'signupStyling/signup_BasicLayout.dart';
import 'checkemail_screen.dart';

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


  void toggleHiddenText() {
    setState(() {
      _hiddenText = !_hiddenText;
    });
  }

  bool isPassword(String password){
    if (password.length >= 12)
      {
        var str = password.trim();
        if (identical(password, str))
        return true;
        else
          return false;
      }
    else
      return false;
  }

  //Creates a popup alert
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
          errorEmail = EnumError.hide;
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
///////////////////////////////////////////////////////////////////////////////////////////
  void firstNameChecking() {
    if (firstName?.isNotEmpty ?? false) {

        setState(() {
          errorFirstName = EnumError.hide;

        });
      }
     else if (firstName?.isEmpty ?? true) {
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
    }
    else if (lastName?.isEmpty ?? true) {
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
        final ageNumber = num.tryParse(age); //to check if the string can be numeric or not
        if (ageNumber == null) {
          errorAge = EnumError.show;
          ageErrorText = "Invalid age";
        }
        else
          {
            if (ageNumber < 0 || ageNumber > 120)
              {
                errorAge = EnumError.show;
                ageErrorText = "Invalid age";
              }
            else if (ageNumber >= 0 && ageNumber < 13)
              {
                errorAge = EnumError.show;
                ageErrorText = "In order to use Flickr, you must be 13 or older";
              }
            else
              {
              errorAge = EnumError.hide;
              }
          }
      }
      );
    }
    else if (age?.isEmpty ?? true) {
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
          passwordErrorText = "Please use at least: 12 characters and no leading spaces";
        }
      });
    }
    else if (password?.isEmpty ?? true) {
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
                errorText: (errorFirstName == EnumError.show) ? "Required" : null,
                labelText: 'First name',
                focusedBorder: KOutlineInputBorderFocused,
                border: KOutlineInputBorder,
              ),
            ), //First Name Text field
            SizedBox(height: 10.0),
//////////////////////////////////////////////////////////////////////////////////////////////////
            TextField(
              onChanged: (valueLastName) {
                lastName = valueLastName;
              },
              decoration: InputDecoration(
                errorText: (errorLastName == EnumError.show) ? "Required" : null,
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
                errorText: (errorEmail == EnumError.show) ? "Required" : null,
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
                  errorText:
                  (errorPassword == EnumError.show) ? passwordErrorText : null,
                  labelText: 'Password',
                  focusedBorder: KOutlineInputBorderFocused,
                  border: KOutlineInputBorder,
                ),
              ), //Password Text field
            SizedBox(height: 25.0),

            Container(
              height: 40.0,
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  emailChecking();
                  firstNameChecking();
                  lastNameChecking();
                  ageChecking();
                  passwordChecking();

                  if (errorEmail == EnumError.hide && errorFirstName == EnumError.hide && errorLastName == EnumError.hide && errorAge == EnumError.hide && errorPassword == EnumError.hide) {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) {
                    return CheckEmailScreen(email);
                    },
                    ),
                    );
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
