import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'loginStyling/login_BasicLayout.dart';
import 'package:flickr_android/constants.dart';
import 'loginStyling/login_Widgets.dart';
import 'package:flickr_android/enums.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget ForgotPassWordScreen() {
  LoginBasicLayout loginBasicLayout = LoginBasicLayout(ForgotPassWord());
  return loginBasicLayout;
}

class ForgotPassWord extends StatefulWidget {
  @override
  _ForgotPassWordState createState() => _ForgotPassWordState();
}

class _ForgotPassWordState extends State<ForgotPassWord> {
  EnumError errorEmail = EnumError.hide;
  String email;
  bool visibilty = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(25.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.lock,
              color: Colors.grey[600],
            ),
            SizedBox(height: 10.0),
            Text(
              KForgotPW,
              style: TextStyle(
                fontSize: KLogInToFlickrTextSize,
              ),
            ), // Flickr Icon and Log in to flickr
            SizedBox(height: 20.0),
            Text(
              KForgotPWInstruction,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            Visibility(
              visible: false,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Container(
                    height: 40.0,
                    color: KWarningColor,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        KWarningText,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                      ),
                    ),
                  )
                ],
              ),
            ),
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
            ),
            SizedBox(height: 25.0),
            Container(
              height: 40.0,
              width: double.infinity,
              child: TextButton(
                onPressed: () {},
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
                  'Send email',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
                // TODO// @arwa- adding a functionality to resend mail
              },
              child:
                  Text("Can't access your email? ", style: KHyperlinkedTexts),
            ), //
          ],
        ),
      ),
    ); //Email Text field
  }
}
