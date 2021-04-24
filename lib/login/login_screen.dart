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
            onTap: () {},
            decoration: InputDecoration(
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
              // hintText: 'Email address',
              // hintStyle: TextStyle(
              //   color: Colors.grey,
              // ),
            ),
          ),
          TextField(),
        ],
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
