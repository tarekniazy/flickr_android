import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flickr_android/constants.dart';
import 'loginStyling/login_Widgets.dart';

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
              decoration: InputDecoration(
                //  errorText: 'Required',
                labelText: 'Email address',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.8,
                    color: Colors.blue[800],
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
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue[600]),
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

// child: FlutterLogin(
//   theme: LoginTheme(
//     cardTheme: CardTheme(
//       elevation: 0.0,
//       shadowColor: Colors.white,
//     ),
//     //primaryColor: Colors.white,
