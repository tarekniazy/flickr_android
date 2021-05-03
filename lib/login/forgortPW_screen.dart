import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'loginStyling/login_BasicLayout.dart';
import 'package:flickr_android/constants.dart';
import 'loginStyling/login_Widgets.dart';
import 'package:flickr_android/enums.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Services/networking.dart';

Widget ForgotPassWordScreen(String mail) {
  String passedEmail = mail;
  LoginBasicLayout loginBasicLayout =
      LoginBasicLayout(ForgotPassWord(passedEmail));
  return loginBasicLayout;
}

class ForgotPassWord extends StatefulWidget {
  ForgotPassWord(this.passedEmail);
  final passedEmail;
  @override
  _ForgotPassWordState createState() => _ForgotPassWordState();
}

class _ForgotPassWordState extends State<ForgotPassWord> {
  EnumError errorEmail = EnumError.hide;
  String email;
  bool visibilty = false;
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
            ), // lock-secure icon
            SizedBox(height: 10.0),
            Text(
              KForgotPW,
              style: TextStyle(
                fontSize: KLogInToFlickrTextSize,
              ),
            ), // Forget your Flickr Password text
            SizedBox(height: 20.0),
            Text(
              KForgotPWInstruction,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ), // Explanation for forgot password instruction
            Visibility(
              //TODO arwa- assign visibilty according to wether the email has a flutter account or not
              visible: visibilty,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  kClipRRect,
                ],
              ),
            ), // warning sign
            SizedBox(height: 20.0),
            TextField(
              controller: TextEditingController(text: widget.passedEmail),
              onChanged: (value) {
                email = value;
              },
              decoration: InputDecoration(
                errorText: (errorEmail == EnumError.show) ? "Required" : null,
                labelText: 'Email address',
                focusedBorder: KOutlineInputBorderFocused,
                border: KOutlineInputBorder,
              ),
            ), // recovery email textfield
            SizedBox(height: 25.0),
            Container(
              height: 40.0,
              width: double.infinity,
              child: TextButton(
                onPressed: () async {


                  Map<String, dynamic> Body = {
                    "email": email,
                  };

                  //TODO change next phases

                  NetworkHelper req = new NetworkHelper(
                      "https://4ed699e3-6db5-42c4-9cb2-0aca2896efa9.mock.pstmn.io/v3/forget?id=56");

                  var res = await req.postData(Body);

                  if (res.statusCode == 200) {
                    Navigator.pushNamed(context, 'Home');
                  } else {
                    print(res.statusCode);
                  }



                  //TODO arwa- send mail for recovery (probably an equivalent not actual mail)
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
                  'Send email',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ), // Send email button
            TextButton(
              onPressed: () {
                // TODO// @arwa- adding a functionality to access email
              },
              child:
                  Text("Can't access your email? ", style: KHyperlinkedTexts),
            ), // can't access your email?
          ],
        ),
      ),
    ); //Email Text field
  }
}
