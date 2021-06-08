import 'package:flutter/material.dart';
import '../main_widgets_test.dart';
import 'package:flickr_android/getStarted/getStarted_Page.dart';
import 'package:flickr_android/login/login_screen.dart';

void main() {
  Widget testWidget = new MediaQuery(
      data: new MediaQueryData(),
      child: new MaterialApp(
          initialRoute: 'getStarted',
          routes: {
            'getStarted': (context) => GetStarted(),
            'LogIn': (context) => LoggingInScreen()
          },
          home: GetStarted()));

  TesterOfWidgets testerOfWidgets = TesterOfWidgets(testWidget);
  testerOfWidgets.findTextOnce(textToFind: 'Save all your photos and videos');
  testerOfWidgets.findPage(numberOfPage: 1);
  testerOfWidgets.findElevatedButton();
}
