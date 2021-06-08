import 'package:flickr_android/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'getStarted/getStarted_Page.dart';
import 'login/login_screen.dart';

//Pull Request test
void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => GetStarted(),
        'LogIn': (context) => LoggingInScreen()
      },
    ),
  );
}
