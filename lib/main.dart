import 'package:flickr_android/home/explore/explore.dart';
import 'package:flickr_android/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'getStarted/getStarted_Page.dart';
import 'home/home.dart';
import 'home/notifications/notifications.dart';
import 'login/login_screen.dart';
import 'home/explore/explore.dart';
import 'home/customeWidgets.dart';

void main() {
  runApp(
  MaterialApp(
   initialRoute: '/',
    routes: {
        '/':(context)=>GetStarted(),
        'LogIn':(context)=>LoggingInScreen()


    },
  ),
  );
}


