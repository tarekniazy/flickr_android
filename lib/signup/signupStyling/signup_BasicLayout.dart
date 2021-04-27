import 'package:flickr_android/constants.dart';
import 'package:flutter/material.dart';
import 'signup_Widgets.dart';

class SignUpBasicLayout extends StatelessWidget {
  SignUpBasicLayout(this.signupBody);
  final Widget signupBody;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
        body: signupBody,
      ),
    );
  }
}
