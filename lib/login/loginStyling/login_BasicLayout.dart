import 'package:flickr_android/constants.dart';
import 'package:flutter/material.dart';
import 'login_Widgets.dart';



/// This is the basic UI of the logIn Screen which takes a widget as an input to load it to the UI
class LoginBasicLayout extends StatelessWidget {
  LoginBasicLayout(this.myPageBody);
  final Widget myPageBody;
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
        body: myPageBody,
      ),
    );
  }
}
